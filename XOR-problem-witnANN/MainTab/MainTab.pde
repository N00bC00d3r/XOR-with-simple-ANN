int totalTrain = 0;
int totalTest = 0;
int totalRight = 0;
float sucess = 0;
int testCard = 0;
int trainCard = 0;

Neural_Network neuralnet;
Button trainB, testB;

void setup() {

  size(1366,500);
  setupSigmoid();
  loadData();
  neuralnet = new Neural_Network(2, 64, 2);
  smooth();
  stroke(150);
  
  trainB = new Button(width*0.06, height*0.9, "Train");
  testB = new Button(width*0.11, height*0.9, "Test");
}

void draw() {

  background(255);
  neuralnet.display();
  
  fill(100);
  text("Test card: #" + testCard, width*0.18, height*0.89);
  text("Train card: " + trainCard, width*0.18, height*0.93);
  text("Training Card label: " + training_set[trainCard].output, width*0.18, height*0.97);
  
  text("Total train: " + totalTrain, width*0.32, height*0.89);
  text("Total test: " + totalTest, width*0.32, height*0.93);
  
  if(totalTest>0) sucess = float(totalRight)/float(totalTest);
  text("Success rate: " + nfc(sucess, 2), width*0.44, height*0.89);
  text("Testing Card label: " + testing_set[testCard].output, width*0.44, height*0.93);
  
  trainB.display();
  testB.display();
}

void mousePressed() {
  if (trainB.hover()) {
    for (int i = 0; i < 500; i++) {
      trainCard = (int) floor(random(0, training_set.length));
      neuralnet.feedforward(training_set[trainCard]);
      neuralnet.train(training_set[trainCard].outputs);
      totalTrain++;
    }
  } else if (testB.hover()){
    testCard = (int) floor(random(0, testing_set.length));
    neuralnet.feedforward(testing_set[testCard]);
    neuralnet.display();
    if(neuralnet.bestIndex == testing_set[testCard].output) totalRight ++;
    totalTest ++;
  }
  redraw();
}
