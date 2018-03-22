package matrix;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class AdjTable {
	private ArrayList<ArrayList<Integer>> adjTable; //�洢�ڽӱ�����ݽṹ
	private int size; //�ڵ������
	private String pathesString; //��¼���е�·���ַ���
	
	/**
	 * ���캯���е�������
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
	 * ����������ȵ����е�·
	 * 
	 * @param len
	 * @return
	 */
	public String DisplayPath(int len) {
		this.pathesString = ""; //��ʼ�����ַ���Ϊ��
		int[] path = new int [len+1]; //�����洢ĳһ����·,��Ȼ��Ϊ2�ĵ�·��Ҫ����3���ڵ�
		for (int i = 0; i < this.size; i++) {
			path[0] = i; //�������
			this.GoPath(path, 1); //��ʼʱ��path���������Ⱦ�Ϊ1
		}
		return this.pathesString;
	}
	
	/**
	 * �ݹ�ʵ��������ȣ��ҵ�����ָ�����ȵĵ�·
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
	 * ����ĳһ��path�����ݣ����ݴ�С1~size
	 * 
	 * @param path
	 * @return
	 */
	private String GetSinglePath(int[] path) {
		String tempPath = String.valueOf(path[0]+1); //��ʱ�洢����path��Ϣ���ַ���
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
