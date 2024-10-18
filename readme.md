# Face Mask Detection Project

This project detects face masks using a MobileNetV2-based model and can be applied to both images and live video streams. The project also provides a web interface built with Streamlit to interact with the model.

## Project Details

- **Model Architecture:** The model uses the pre-trained MobileNetV2 as a feature extractor, with custom fully connected (FC) layers for classification.
- **Training:** The `train_mask_detector.py` script is used to train the model on a dataset of masked and unmasked faces. Data augmentation is applied during training using the `ImageDataGenerator`.
- **Loss Function:** Binary crossentropy
- **Optimizer:** Adam
- **Output:** The trained model is saved as `mask_detector.model` and a plot of training/validation loss and accuracy is saved as `plot.png`.

## Prerequisites

- Docker installed on your system
- A working webcam for live video detection
- Python (for training on local machine)

## Setup Instructions

### 1. Clone the Project

First, clone the repository containing the project:

```bash
git clone https://github.com/HariMalam/Face-Mask-Detection
cd Face-Mask-Detection
```

Ensure the `src` folder contains your project's code and model files.

### 2. Docker Environment Setup

#### Step 1: Build the Docker Image

```bash
docker build -t cv-project-env .
```

#### Step 2: Allow Docker to Access Display (For Live Video on Linux)

**Linux:**
```bash
xhost +local:docker
```

**Windows:**
No equivalent step is needed since video access works through the Docker container's default settings.

#### Step 3: Run the Docker Container

Run the container with access to your webcam and shared volumes for the project code.

**Linux:**
```bash
docker run -it --name face-mask-detection --device=/dev/video0 \
    -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v $(pwd)/src:/app/src -p 8501:8501 cv-project-env
```

**Windows:**
```bash
docker run -it --name face-mask-detection --device=/dev/video0 \
    -v $(pwd)/src:/app/src -p 8501:8501 cv-project-env
```

This command starts the container and maps the necessary volumes and devices.

### 3. Running the Project

Inside the Docker container, navigate to the `/app/src` directory where the project scripts are located.

#### Training the Model

To train the face mask detector on a dataset:

```bash
python3 train_mask_detector.py --dataset dataset
```

- **Dataset:** The dataset should contain two folders: one for masked faces and one for unmasked faces.
- **Model Output:** The trained model will be saved as `mask_detector.model`.

#### Detecting Masks on an Image

To detect masks in a static image:

```bash
python3 detect_mask_image.py --image images/pic1.jpeg
```

Replace `images/pic1.jpeg` with the path to the image you want to process.

#### Detecting Masks in Live Video Feed

To detect masks in real-time using your webcam:

```bash
python3 detect_mask_video.py --face /app/src/face_detector \
    --model /app/src/mask_detector.model --confidence 0.5
```

#### Running the Web Interface

To run the Streamlit web application:

```bash
streamlit run app.py
```

After running this command, visit `http://localhost:8501` in your web browser to interact with the model through a web interface.

### 4. Model Training Details

- **Data Augmentation:** Applied with rotation, zoom, width/height shift, shear, and horizontal flip.
- **Base Model:** MobileNetV2 with pre-trained weights from ImageNet, used as a feature extractor.
- **Custom Head:** Added fully connected layers and softmax for mask/no-mask classification.
- **Epochs:** 20
- **Batch Size:** 32
- **Optimizer:** Adam
- **Learning Rate:** 1e-4

The model freezes the base MobileNetV2 layers during training to ensure that only the custom head is updated.

### 5. Additional Notes

- Ensure that you have the webcam properly connected and accessible in the container for live video detection.
- Adjust confidence levels or paths to models as needed.
- The container automatically exposes port 8501 for the Streamlit app.

## Credits

This project was developed by:

- **Malam Haribhai Devshibhai**
- **Enrollment No.:** 2101060116051
- **Email:** malamharid@gmail.com
- **GitHub:** [@HariMalam](https://github.com/HariMalam)

### Tools Used:
- OpenCV for image and video processing
- Keras and TensorFlow for model training
- Streamlit for the web interface