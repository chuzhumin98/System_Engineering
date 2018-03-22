package matrix;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class AdjTable {
	private ArrayList<ArrayList<Integer>> adjTable; //存储邻接表的数据结构
	private int size; //节点的数量
	private String pathesString; //记录所有道路的字符串
	
	/**
	 * 构造函数中导入数据
	 * 
	 * @param filePath
	 * @throws FileNotFoundException
	 */
	public AdjTable(String filePath) throws FileNotFoundException {
		File file = new File(filePath);
		Scanner input = new Scanner(file);
		this.size = input.nextInt();
		this.adjTable = new ArrayList<ArrayList<Integer>>();
		for (int i = 0; i < this.size; i++) {
			ArrayList<Integer> myLink = new ArrayList<Integer>();
			for (int j = 0; j < this.size; j++) {
				if (input.nextInt() == 1) {
					myLink.add(j);
				}
			}
			this.adjTable.add(myLink);
		}
		/*for (int i = 0; i < this.size; i++) {
			System.out.print(i+": ");
			for (Integer num: this.adjTable.get(i)) {
				System.out.print(num+" ");
			}
			System.out.println();
		} */
	}
	
	/**
	 * 输出给定长度的所有道路
	 * 
	 * @param len
	 * @return
	 */
	public String DisplayPath(int len) {
		pathesString = ""; //初始化该字符串为空
		int[] path = new int [len]; //用来存储某一条道路
		int index = 0; //记录当前path的索引值
		for (int i = 0; i < this.size; i++) {
			path[0] = i; //定义起点
			index = 1;
			
		}
		return null;
	}
	
	/**
	 * 递归实现深度优先，找到所有指定长度的道路
	 * 
	 * @param path
	 * @param index
	 */
	private void GoPath(int[] path, int index) {
		if (index == path.length) {
			this.pathesString += "";
		}
	}
	
	/**
	 * 加载入某一条path的数据
	 * 
	 * @param path
	 */
	private void GetSinglePath(int[] path) {
		String tempPath = ""; //临时存储这条path信息的字符串
		
	}
	
	public static void main(String[] args) throws FileNotFoundException {
		AdjTable adj1 = new AdjTable("input/matrix_1_2.txt");
		
	}
}
