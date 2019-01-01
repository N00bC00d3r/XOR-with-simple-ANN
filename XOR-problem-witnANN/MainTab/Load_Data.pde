Card [] testing_set; // the set we use to test (4)
Card [] training_set; // the set we use to train (4)

class Card { // This class contains all the functions to format and save the data

  float [] inputs;
  float [] outputs;
  int output;

  Card() {
    inputs = new float [2]; // the are 2 numbers either 0 or 1
    outputs = new float[2]; // the number of possible outputs 0 and 1
    outputs[0]=-1;outputs[1]=-1;
  }

  void load_inputs(float a,float b){
    inputs[0]=a;
    inputs[1]=b;
    
  }

  void load_output(int target) {
    outputs[target]=1.0; 
    output=target;
  }
  
}

void loadData(){ // In this function we initialise all out data in two seperate arrays, training[] and test[]
  training_set = new Card [4];
  testing_set = new Card [4];
  for(int i=0;i<4;i++){
    training_set[i]=new Card();
     testing_set[i]=new Card();
  }
  training_set[0].load_inputs(0,0);
  training_set[0].load_output(0);
  
  training_set[1].load_inputs(0,1);
  training_set[1].load_output(1);
  
  training_set[2].load_inputs(1,0);
  training_set[2].load_output(1);
  
  training_set[3].load_inputs(1,1);
  training_set[3].load_output(0);
  
  //testing set
  testing_set[0].load_inputs(0,0);
  testing_set[0].load_output(0);
  
  testing_set[1].load_inputs(0,1);
  testing_set[1].load_output(1);
  
  testing_set[2].load_inputs(1,0);
  testing_set[2].load_output(1);
  
  testing_set[3].load_inputs(1,1);
  testing_set[3].load_output(0);  
  
  
}
