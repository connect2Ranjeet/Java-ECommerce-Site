package DAO;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TrendingDAO extends DatabaseObject implements Runnable{
	private static final String name = "Trending";
	private static TrendingDAO instance = null;
	
	
	private static int trendingCount=10;//number of items to display in trending
    private static int trendingDateInterval = 10;//interval to check for trending items (days)
    private static int updateInterval = 1;//interval of time to periodically run update (minutes)
    private static boolean firstRun = true;
    private static Thread thread = null;
  //behaving like a struct to store productID and quantity (prioritize them)
  	class ProductQuantity{
  		int productID;
  		int quantity;
  		}
	
	protected TrendingDAO(){
		super();
		
		//initial update
		
	}
	
	public String getName() {
	   return name;
	}
	
	public static Thread getThread() {
		return thread;
	}
	
	public static TrendingDAO getInstance() {
		if (instance == null) {
			instance =  new TrendingDAO();
			thread = new Thread(instance, "Trending Thread");
			thread.start();
			return instance;
		}
		else
			return instance;
	}
	
	@Override
	public void run() {
		try {
			while (true) {
				System.out.println("Thread started! Now waiting.");
				if (firstRun == true) {
					System.out.println("First Run! Calling trending Update");
					updateTrendingItems();
					firstRun = false;
				} else {
					Thread.sleep(updateInterval*60*1000);
					System.out.println("Calling trending Update");
					updateTrendingItems();
				}
			}
		} catch (InterruptedException e){
			System.out.println("Trending Update Thread Interrupted!");
		}
	}
	
	public Map<String, List<String>> getTrendingItems()
	{
		//For now just updating with delta time TODO: add threads			
		//Create map to use to query
		Map<String, List<String>> trendingItems = new HashMap<String, List<String>>();
		
		//populate columns
		populate_columns(trendingItems);
		
		return select(trendingItems,true);
	}
	
	private void updateTrendingItems()
	{
		
		//new trending item list
		Map<String, List<String>> newTrendingItems = new HashMap<String, List<String>>();
		
		//fill the columns:
		populate_columns(newTrendingItems);
		
		//get all the transactions
		Map<String, List<String>> allTransactions = TransactionsDAO.getInstance().getAllTransactions();
		
		//get all the productdao
		ProductDAO  productTables = ProductDAO.getInstance();
		
		
		List<ProductQuantity> quantityTracker = new ArrayList<ProductQuantity>();
		
		//TODO: implement prioritizing greatest quantities within certain amount of days
		for(int i = 0; i < allTransactions.get("Quantitiy").size(); ++i)
		{
			ProductQuantity product = new ProductQuantity();
			
			product.productID = Integer.parseInt(allTransactions.get("Product_ID").get(i));
			product.quantity = Integer.parseInt(allTransactions.get("Quantity").get(i));
					
			//quantityTracker.add(product); TODO: this looks like a bug so I commented it out. it should only add later
			
			boolean existsAlready = false;//check to see if it is already in the table
			for(int j = 0; j < quantityTracker.size(); ++j)
			{
				if(quantityTracker.get(j).productID == product.productID)
				{
					quantityTracker.get(j).quantity += product.quantity;//update quantity
					existsAlready = true;
				}
			}
			if(!existsAlready)//not already in the list so add it
			{
				quantityTracker.add(product);
			}
		}
		
		//find the max trendingCount times
		//make array to hold trendingCount values
		int[] trending = new int[trendingCount];
		for(int i = 0; i < trendingCount; ++i)
		{
			int currentMax = 0;
			int indexOfMax = 0;
			for(int j = 0; j < quantityTracker.size();)
			{
				if(quantityTracker.get(j).quantity > currentMax)
				{
					currentMax = quantityTracker.get(j).quantity;
					indexOfMax = j;
					quantityTracker.remove(j);
					//don't increment since removed object;
				}
				else
				{
					++j;
				}
			}
			trending[i] = quantityTracker.get(indexOfMax).productID;
		}
		
		for(int i = 0; i < trending.length; ++i)
		{
			//go through and add each product that is trending to trending items
			newTrendingItems.putAll(productTables.getProductByID(trending[i]));
		}
		
		
		
		Map<String, List<String>> oldTrending = new HashMap<String, List<String>>();
		populate_columns(oldTrending);
		
		oldTrending = select(oldTrending,true);
		
		//update old with the new
		update(oldTrending,newTrendingItems);
		
	}

	
}
