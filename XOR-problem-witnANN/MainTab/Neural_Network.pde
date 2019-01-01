//this integers are for display purpose only.
int  no_of_neurons_input_layer=1;
int  no_of_neurons_hidden_layer=8;
int  no_of_neurons_output_layer=2;


class Neural_Network{
  Neuron[] input_layer;
  Neuron[] hidden_layer;
  Neuron[] output_layer;
  int bestIndex=0;
  
  
  Neural_Network(int input,int hidden,int output){
    input_layer=new Neuron[input];
    hidden_layer=new Neuron[hidden];
    output_layer=new Neuron[output];
    for(int i=0;i<input;i++)
    {
        input_layer[i]=new Neuron();
    }
    for(int i=0;i<hidden;i++)
    {
        hidden_layer[i]=new Neuron(input_layer);
    }
    for(int i=0;i<output;i++)
    {
        output_layer[i]=new Neuron(hidden_layer);
    }
  }
  void feedforward(Card card){
    //setting the cards input to the output of the input layer
    for(int i=0;i<input_layer.length;i++){
        input_layer[i].output=card.inputs[i];
    }
    
    //feedforwarding the hidden layer
    for(int i=0;i< hidden_layer.length;i++){
         hidden_layer[i].feedforward();
    }
    //feedforwarding the output layer
    for(int i=0;i< output_layer.length;i++){
         output_layer[i].feedforward();
    }    
    
  }
  void train(float[] targets){
    for(int i=0;i<output_layer.length;i++){
      output_layer[i].setError(targets[i]);
      output_layer[i].train();
    }
    float best=-1.0;
    for(int i=0;i<output_layer.length;i++){
        if(output_layer[i].output>best){
        //  best=output_layer[i].output;
          bestIndex=i;
        }
    }
    for(int i=0;i<hidden_layer.length;i++){
      hidden_layer[i].train();
    }
  }
//   Following methods are used for visual representation of the Neural Net

  void drawCon() {

    for (int i = 0; i < hidden_layer.length; i++) {
      float [] res = hidden_layer[i].getStrength();
      stroke(200);
      strokeWeight(pow(10, res[1])/35);
      line(
        (i%no_of_neurons_hidden_layer) * height / 20.0 + width * 0.53, 
        (i/no_of_neurons_hidden_layer) * height / 20.0 + height * 0.32, 
        (int(res[0])%no_of_neurons_input_layer) * height / 20.0 + width * 0.05, 
        (int(res[0])/no_of_neurons_input_layer) * height / 20.0 + height * 0.13);
    }

    for (int i = 0; i < output_layer.length; i++) {
      float [] res = output_layer[i].getStrength();
      stroke(res[1]*200);
      strokeWeight(pow(10, res[1])/35);
      line(
        width * 0.85, 
        (i%no_of_neurons_output_layer) * height / 15.0 + height * 0.2,
        (res[0]%no_of_neurons_hidden_layer) * height / 20.0 + width * 0.53, 
        (res[0]/no_of_neurons_hidden_layer) * height / 20.0 + height * 0.32);
    }
    strokeWeight(1);
  }
  void display() {

    drawCon();

    // Draw the input layer
    for (int i = 0; i < input_layer.length; i++) {
      pushMatrix();
      translate(
        (i%no_of_neurons_input_layer) * height / 20.0 + width * 0.05, 
        (i/no_of_neurons_input_layer) * height / 20.0 + height * 0.13);
      input_layer[i].display();
      popMatrix();
    }

    // Draw the hidden layer
    for (int j = 0; j < hidden_layer.length; j++) {
      pushMatrix();
      translate(
        (j%no_of_neurons_hidden_layer) * height / 20.0 + width * 0.53, 
        (j/no_of_neurons_hidden_layer) * height / 20.0 + height * 0.32);
      hidden_layer[j].display();
      popMatrix();
    }

    // Draw the output layer
    float [] resp = new float [output_layer.length];
    float respTotal = 0.0;
    for (int k = 0; k < output_layer.length; k++) {
      resp[k] = output_layer[k].output;
      respTotal += resp[k]+1;
    }

    for (int k = 0; k < output_layer.length; k++) {
      pushMatrix();
      translate(
        width * 0.85, 
        (k%no_of_neurons_output_layer) * height / 15.0 + height * 0.2);
      output_layer[k].display();
      fill(150);
      strokeWeight(sq(output_layer[k].output)/2);
      line(12, 0, 25, 0);
      text(k%no_of_neurons_output_layer, 40, 5);
      text(nfc(((output_layer[k].output+1)/respTotal)*100, 2) + "%", 55, 5);
      popMatrix();
      strokeWeight(1);
    }
    float best = -1.0;
    for (int i =0; i < resp.length; i++) {
      if (resp[i]>best) {
        best = resp[i];
        bestIndex = i;
      }
    }
    stroke(255, 0, 0);
    noFill();
    ellipse(
      width * 0.85, (bestIndex%no_of_neurons_output_layer) * height / 15.0 + height * 0.2, 
      25, 25);
  }
}
