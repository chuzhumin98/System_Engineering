package stratify;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Scanner;

public class Stratify {
	private int[][] matrix; //�洢�ɴ����
	private int size; //��¼�ɴ�����ά��
	private ArrayList<ArrayList<ArrayList<Integer>>> structure; 
	    //�洢���ֲ�Ľṹ������һ��array�����洢��������ݣ������Զ�����;
	    //�м�һ��array�洢�ò��еĸ������壬�ڲ�array�洢�����а�����Ԫ��
	
	/**
	 * ���캯����ͨ���ļ�����ɴ����
	 * ��ʽ��
	 * ��һ�У������ά��n
	 * ����n�У��ɿո������n�����֣���ʾÿ�е�Ԫ��
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
	 * ���в�λ��֣��Զ����£�
	 */
	public void DoStratify() {
		if (this.structure != null) {
			return; //�����֮ǰ�Ѿ����й��˲�λ���
		}
		this.structure = new ArrayList<ArrayList<ArrayList<Integer>>>();
		ArrayList<Integer> candidate = new ArrayList<Integer>(); 
		    //��ѡ�����洢��δ�����ֲ�εĽڵ�
		ArrayList<Integer> active = new ArrayList<Integer>(); //��Ծ������ǰ��ΰ����Ľڵ�
		for (int i = 0; i < this.size; i++) { //��ʼ����ѡ��
			candidate.add(i);
		}
		while (candidate.size() > 0) {
			for (Integer comparing: candidate) {
				boolean isActive = true; //��¼Ԫ��comparing�Ƿ���Ҫ�����Ծ��
				for (Integer compared: candidate) {
					if (this.matrix[comparing][compared] == 1 && 
							this.matrix[compared][comparing] == 0) {
						//����ܹ�ָ��comparing�ڵ�Ľڵ����䲻���ڻ�ָ��ϵ�����䲻�Ƕ���ڵ�
						isActive = false;
						break;
					}
				}
				if (isActive) {
					active.add(comparing);
				}
			}
			for (Integer item: active) { //�ж���ɺ󣬽���Ծ�ڵ��Ƴ���ѡ��
				candidate.remove(item);
				//System.out.print(item+" ");
			}
			//System.out.println();
			ArrayList<ArrayList<Integer>> activeLayer = 
					new ArrayList<ArrayList<Integer>>();
			    //��¼��ǰ��Ծ��Ľṹ
			while (active.size() > 0) {
				ArrayList<Integer> myGroup = new ArrayList<Integer>();
				int represent = active.get(0); //��һ��������Ĵ���Ԫ��
				myGroup.add(represent);
				active.remove(0); //�ڻ�Ծ����ɾ������Ԫ
				for (int i = active.size()-1; i >= 0; i--) { //�Ӻ���ǰ����ɾ��ʱ��Ӱ��
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
	 * ���в�λ��֣��Ե����ϣ�
	 */
	public void DoReverseStratify() {
		if (this.structure != null) {
			return; //�����֮ǰ�Ѿ����й��˲�λ���
		}
		this.structure = new ArrayList<ArrayList<ArrayList<Integer>>>();
		ArrayList<Integer> candidate = new ArrayList<Integer>(); 
		    //��ѡ�����洢��δ�����ֲ�εĽڵ�
		ArrayList<Integer> active = new ArrayList<Integer>(); //��Ծ������ǰ��ΰ����Ľڵ�
		for (int i = 0; i < this.size; i++) { //��ʼ����ѡ��
			candidate.add(i);
		}
		while (candidate.size() > 0) {
			for (Integer comparing: candidate) {
				boolean isActive = true; //��¼Ԫ��comparing�Ƿ���Ҫ�����Ծ��
				for (Integer compared: candidate) {
					if (this.matrix[comparing][compared] == 0 && 
							this.matrix[compared][comparing] == 1) {
						//����ܹ�ָ��comparing�ڵ�Ľڵ����䲻���ڻ�ָ��ϵ�����䲻�Ƕ���ڵ�
						isActive = false;
						break;
					}
				}
				if (isActive) {
					active.add(comparing);
				}
			}
			for (Integer item: active) { //�ж���ɺ󣬽���Ծ�ڵ��Ƴ���ѡ��
				candidate.remove(item);
				//System.out.print(item+" ");
			}
			//System.out.println();
			ArrayList<ArrayList<Integer>> activeLayer = 
					new ArrayList<ArrayList<Integer>>();
			    //��¼��ǰ��Ծ��Ľṹ
			while (active.size() > 0) {
				ArrayList<Integer> myGroup = new ArrayList<Integer>();
				int represent = active.get(0); //��һ��������Ĵ���Ԫ��
				myGroup.add(represent);
				active.remove(0); //�ڻ�Ծ����ɾ������Ԫ
				for (int i = active.size()-1; i >= 0; i--) { //�Ӻ���ǰ����ɾ��ʱ��Ӱ��
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
	 * ���ֲ���д��string���
	 */
	public String toString() {
		//this.DoStratify();
		String results = "";
		for (ArrayList<ArrayList<Integer>> layer: this.structure) {
			for (ArrayList<Integer> group: layer) {
				results += (group.get(0)+1); //�����һ��Ҫ����Ϊindex��0��ʼ
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
