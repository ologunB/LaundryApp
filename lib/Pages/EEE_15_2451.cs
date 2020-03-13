using System;
					
public class Program
{
	public static void Main()
	{
		Console.WriteLine("Which multiplication table do you want? ");
		Double num = Convert.ToDouble(Console.ReadLine());
		Console.WriteLine("To which length? ");
		int length = Int32.Parse(Console.ReadLine());
 		doMultiTable(num, length );
	}
	
	static void doMultiTable(Double num, int length){
		Console.WriteLine("The Multiplication table of " + num + " is \n");

		for(int i = 0; i < length + 1; i++){
			Console.WriteLine(num + " x " + i + " = " + num * i);
		}
	}
}