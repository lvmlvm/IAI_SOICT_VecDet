# if [ $# -ne 1 ]; then
#   echo "Usage: $0 <predict_file>"
#   exit 1
# fi

# predict_file="$1"

echo "PRUNING BY CONF SCORE"

python post_process/src/tools/conf_filter_stage1.py --input_file predict_18_raw.txt

rm -rf post_process/data_reorganized

mkdir post_process/data_reorganized
mkdir post_process/data_reorganized/all_cams


mkdir post_process/data_reorganized/all_cams/images
mkdir post_process/data_reorganized/all_cams/full_boxes
mkdir post_process/data_reorganized/all_cams/pruned_boxes

echo "==========COPYING TEST SET AND PERFORMING INTER-CLASS NMS=========="

# Copy all images to pre-processing folder
cp -r "data/private_test"/* "post_process/data_reorganized/all_cams/images"

# Splitting predict.txt into individual YOLO box files
python post_process/src/tools/intra_class_nms.py --input_file predict_18.txt \
                                           --iou_thresh 0.65

# Perform inter-class NMS, while exporting bounding box files to pre-processing folder
python post_process/src/tools/inter_class_nms.py --input_file predict_18.txt \
                                           --iou_thresh 0.65

# Generate the manifest file
python post_process/src/manifest_generation_private.py