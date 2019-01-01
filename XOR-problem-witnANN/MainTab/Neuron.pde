class Neuron{
  Neuron[] inputs;
  float[] weights;
  float output;
  float error;
  float lr=0.01;
  Neuron(){
    error=0.0;
  }
  Neuron(Neuron[] prev_layer){
    inputs=new Neuron[prev_layer.length];
    weights=new float[prev_layer.length];
    error=0.0;
    for(int i=0;i<weights.length;i++)
    {
        inputs[i]=prev_layer[i];
        weights[i]=random(-1.0,1.0);
    }
  }
  void feedforward(){
    float sum=0.0;
    for(int i=0;i<weights.length;i++)
    {
        sum+=(inputs[i].output*weights[i]);
    }
    output=lookupSigmoid(sum);
    error=0.0;
  }
  void setError(float desired){
    error=desired-output;
  }
  void train(){
      float delta =(1.0 - output) * (1.0 + output) * error * lr;
      for (int i = 0; i < inputs.length; i++) {
        inputs[i].error += weights[i] * error;
        weights[i] += inputs[i].output * delta;
      }
  }
  void display() {
    stroke(200);
    fill(128 * (1 - output));
    ellipse(0, 0, 16, 16);
  }
  float [] getStrength() {
    float ind = 0.0;
    float str = 0.0;
    for (int i = 0; i < weights.length; i++) {
      if (weights[i] > str) {
        ind = i; 
        str = weights[i];
      }
    }
    float [] a = {ind, str};
    return a;
  }
  
}
