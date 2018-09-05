

#define M 512
#define N 531
__kernel

void regex(__global const char *restrict input, int word_num, __global int *restrict output) {

  //int cursor = thread_id*linesize;
  //char line_content[N];
  char temp[N+1]={1};
  int state=0;
  short it_cal[36]={0};
  int m=0;
  bool judge[36][18]={{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0},{0}};
  bool judge_result[36]={0};
  bool sum;
  //short first[36];
  int out=0;
for (int lo=0;lo<word_num;lo+=M){
  //#pragma unroll
  for (int a=0;a<N;a++){
    temp[a] = input[a+lo];
  }
  m=0;

  /*
  #pragma unroll
  for (int b=0;b<36;b++){
    judge_result[b]=0;
  }
  */

  //find out the candidate regionsi
  #pragma unroll 2
  for (int j=0 ;j<M;j++) {
	  if ((temp[j]<=47||temp[j]>=58)&&(temp[j+1]>=48&&temp[j+1]<=57)&&(temp[j+18]<=57)&&(temp[j+18]>=48)&&(temp[j+19]>57||temp[j+19]<48))
	  {  
         it_cal[m]=j+1;
		 m++;
      }
  }
 
  // judge these candidate regions, assume m<=36
  for (int k=0;k<m;k++)
	{   //it_cal[k]=it_cal[k];

		//judge the "region"
		for (int l1=1;l1<6;l1++)
		{
			if (temp[it_cal[k]+l1]>=48&&temp[it_cal[k]+l1]<=57){
				judge[k][l1]=0;
			}
			else{judge[k][l1]=1;}
		}
		
		//judge the "year"
		if ((temp[it_cal[k]+6]==49&&temp[it_cal[k]+7]==57)||(temp[it_cal[k]+6]==50&&temp[it_cal[k]+7]==48)){
			judge[k][6]=0;
				
			}
		else{
			judge[k][6]=1;	
		}
		
		//judge the "month and day"
		if (temp[it_cal[k]+8]>=48&&temp[it_cal[k]+8]<=57&&temp[it_cal[k]+9]>=48&&temp[it_cal[k]+9]<=57){
			judge[k][8]=0;
		}
		else{
			judge[k][8]=1;
		}
		
		/*
		other logic can be added here such as checking the verifying bit
		*/
		
		//accumulate all the judge mid-result
		sum=0;
		for (int l2=0;l2<18;l2++){
			sum|=judge[k][l2];
			judge[k][l2]=0;
		}

		
		// candidate id region checked to be correct
		if (sum==0){
			out+=1;
		}
	}
	//accumulate regions which have the feature of personal-IDs
 
	/*
	other logic like exporting the every number of IDs to the output buffer
	*/
  
 }
 *output=out;
}


