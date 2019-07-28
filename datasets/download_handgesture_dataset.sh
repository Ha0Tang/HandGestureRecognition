FILE=$1

if [[ $FILE != "Cambridge_Hand_Gesture" && $FILE != "Northwestern_Hand_Gesture" && $FILE != "HandGesture" && $FILE != "Action3D" ]]; then
  echo "Available datasets are Cambridge_Hand_Gesture, Northwestern_Hand_Gesture, HandGesture and Action3D"
  exit 1
fi

echo "Specified [$FILE]"

URL=http://disi.unitn.it/~hao.tang/uploads/datasets/HandGestureRecognition/$FILE.tar.gz
TAR_FILE=./datasets/$FILE.tar.gz
TARGET_DIR=./datasets/$FILE/
wget -N $URL -O $TAR_FILE
mkdir -p $TARGET_DIR
tar -zxvf $TAR_FILE -C ./datasets/
rm $TAR_FILE
