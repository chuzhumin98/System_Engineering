package stratify;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Stratify {
	private int[][] matrix; //存储可达矩阵
	private int size; //记录可达矩阵的维数
	private ArrayList<ArrayList<ArrayList<Integer>>> structure; 
	    //存储最后分层的结构，最外一层array用来存储各层的数据，依次自顶向下;
	    //中间一层array存储该层中的各个团体，内层array存储团体中包含的元素
	
	/**
	 * 构造函数，通过文件读入可达矩阵
	 * 格式：
	 * 第一行，矩阵的维数n
	 * 随后的n行，由空格隔开的n个数字，表示每行的元素
	 * 
	 * @param filePath
	 * @throws FileNotFoundException 
	 */
	public Stratify(String filePath) throws FileNotFoundException {
		File file = new File(filePath);
		Scanner input = new Scanner(file);
		this.size = input.nextInt();
		this.matrix = new int [size][size];
		for(int i = 0; i < this.size; i++) {
			for (int j = 0; j < this.size; j++) {
				this.matrix[i][j] = input.nextInt();
				//System.out.print(this.matrix[i][j]+" ");
			}
			//System.out.println();
		}
	}
	
	/**
	 * 进行层次划分（自顶向下）
	 */
	public void DoStratify() {
		if (this.structure != null) {
			return; //这表明之前已经进行过了层次划分
		}
		this.structure = new ArrayList<ArrayList<ArrayList<Integer>>>();
		ArrayList<Integer> candidate = new ArrayList<Integer>(); 
		    //候选集，存储还未被划分层次的节点
		ArrayList<Integer> active = new ArrayList<Integer>(); //活跃集，当前层次包含的节点
		for (int i = 0; i < this.size; i++) { //初始化候选集
			candidate.add(i);
		}
		while (candidate.size() > 0) {
			for (Integer comparing: candidate) {
				boolean isActive = true; //记录元素comparing是否需要记入活跃集
				for (Integer compared: candidate) {
					if (this.matrix[comparing][compared] == 1 && 
							this.matrix[compared][comparing] == 0) {
						//如果能够指向comparing节点的节点与其不存在互指关系，则其不是顶层节点
						isActive = false;
						break;
					}
				}
				if (isActive) {
					active.add(comparing);
				}
			}
			for (Integer item: active) { //判断完成后，将活跃节点移除候选集
				candidate.remove(item);
				//System.out.print(item+" ");
			}
			//System.out.println();
			ArrayList<ArrayList<Integer>> activeLayer = 
					new ArrayList<ArrayList<Integer>>();
			    //记录当前活跃层的结构
			while (active.size() > 0) {
				ArrayList<Integer> myGroup = new ArrayList<Integer>();
				int represent = active.get(0); //找一个新团体的代表元素
				myGroup.add(represent);
				active.remove(0); //在活跃集中删除代表元
				for (int i = active.size()-1; i >= 0; i--) { //从后往前避免删除时有影响
					Integer item = active.get(i);
					if (this.matrix[represent][item] == 1 &&
							this.matrix[item][represent] == 1) {
						myGroup.add(item);
						active.remove(item);
					}
				}
				activeLayer.add(myGroup);
			}
			this.structure.add(activeLayer);
		}
	}
	
	/**
	 * 进行层次划分（自底向上）
	 */
	public void DoReverseStratify() {
		if (this.structure != null) {
			return; //这表明之前已经进行过了层次划分
		}
		this.structure = new ArrayList<ArrayList<ArrayList<Integer>>>();
		ArrayList<Integer> candidate = new ArrayList<Integer>(); 
		    //候选集，存储还未被划分层次的节点
		ArrayList<Integer> active = new ArrayList<Integer>(); //活跃集，当前层次包含的节点
		for (int i = 0; i < this.size; i++) { //初始化候选集
			candidate.add(i);
		}
		while (candidate.size() > 0) {
			for (Integer comparing: candidate) {
				boolean isActive = true; //记录元素comparing是否需要记入活跃集
				for (Integer compared: candidate) {
					if (this.matrix[comparing][compared] == 0 && 
							this.matrix[compared][comparing] == 1) {
						//如果能够指向comparing节点的节点与其不存在互指关系，则其不是顶层节点
						isActive = false;
						break;
					}
				}
				if (isActive) {
					active.add(comparing);
				}
			}
			for (Integer item: active) { //判断完成后，将活跃节点移除候选集
				candidate.remove(item);
				//System.out.print(item+" ");
			}
			//System.out.println();
			ArrayList<ArrayList<Integer>> activeLayer = 
					new ArrayList<ArrayList<Integer>>();
			    //记录当前活跃层的结构
			while (active.size() > 0) {
				ArrayList<Integer> myGroup = new ArrayList<Integer>();
				int represent = active.get(0); //找一个新团体的代表元素
				myGroup.add(represent);
				active.remove(0); //在活跃集中删除代表元
				for (int i = active.size()-1; i >= 0; i--) { //从后往前避免删除时有影响
					Integer item = active.get(i);
					if (this.matrix[represent][item] == 1 &&
							this.matrix[item][represent] == 1) {
						myGroup.add(item);
						active.remove(item);
					}
				}
				activeLayer.add(myGroup);
			}
			this.structure.add(activeLayer);
		}
	}
	
	/**
	 * 将分层结果写成string输出
	 */
	public String toString() {
		//this.DoStratify();
		String results = "";
		for (ArrayList<ArrayList<Integer>> layer: this.structure) {
			for (ArrayList<Integer> group: layer) {
				results += (group.get(0)+1); //这里加一主要是因为index从0开始
				for (int i = 1; i < group.size(); i++) {
					results += "," + (group.get(i)+1);
				}
				results += "  ";
			}
			results += "\n";
		}
		return results;
	}
	
	public static void main(String[] args) throws FileNotFoundException {
		Stratify st1 = new Stratify("input/matrix_2.txt");
		st1.DoReverseStratify();
		System.out.println("following shows the stratified result"
				+ "(from bottom to top):\n"+st1);
		//st1.DoStratify();
		//System.out.println("following shows the stratified result"
			//	+ "(from top to bottom):\n"+st1);
	}
}
