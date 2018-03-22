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
		this.pathesString = ""; //初始化该字符串为空
		int[] path = new int [len+1]; //用来存储某一条道路,当然度为2的道路需要经过3个节点
		for (int i = 0; i < this.size; i++) {
			path[0] = i; //定义起点
			this.GoPath(path, 1); //初始时，path的索引长度均为1
		}
		return this.pathesString;
	}
	
	/**
	 * 递归实现深度优先，找到所有指定长度的道路
	 * 
	 * @param path
	 * @param index
	 */
	private void GoPath(int[] path, int index) {
		if (index == path.length) {
			this.pathesString += this.GetSinglePath(path) + "\n";
			return;
		}
		for (Integer item: this.adjTable.get(path[index-1])) {
			path[index] = item;
			this.GoPath(path, index+1);
		}
	}
	
	/**
	 * 返回某一条path的数据，数据大小1~size
	 * 
	 * @param path
	 * @return
	 */
	private String GetSinglePath(int[] path) {
		String tempPath = String.valueOf(path[0]+1); //临时存储这条path信息的字符串
		for (int i = 1; i < path.length; i++) {
			tempPath += "->"+(path[i]+1);
		}
		return tempPath;
	}
	
	public static void main(String[] args) throws FileNotFoundException {
		AdjTable adj1 = new AdjTable("input/matrix_1_2.txt");
		System.out.println(adj1.DisplayPath(2));
	}
}
