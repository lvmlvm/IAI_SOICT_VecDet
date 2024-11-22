#convert label
python ./data_augmentation/convertlLabel.py --input /data/nighttime --output /data/nighttime_fixed

#remove white lines
python ./data_augmentation/remove.py --input /data/nighttime_fixed --output /data/data_augmentation/remove
python ./data_augmentation/rename.py --input /data/data_augmentation/remove --prefix remove

#add car and remove white line
python ./data_augmentation/add_car.py --input /data/nighttime_fixed --outcar3 /data/add_car/car/03 --outcar5 /data/add_car/car/05 --outcar8 /data/add_car/car/08 --output /data/add_car/car/output
python ./data_augmentation/remove.py --input /data/add_car/car/output --output /data/data_augmentation/add_car_remove
python ./data_augmentation/rename.py --input /data/data_augmentation/add_car_remove --prefix add_car_remove

#add car, flip and remove white line
python ./data_augmentation/flip.py --input /data/nighttime_fixed --output data/add_car/flip
python ./data_augmentation/add_car.py --input /data/add_car/flip --outcar3 /data/add_car/car_flip/03 --outcar5 /data/add_car/car_flip/05 --outcar8 /data/add_car/car_flip/08 --output /data/add_car/car_flip/output
python ./data_augmentation/remove.py --input /data/add_car/car_flip/output --output /data/data_augmentation/add_car_flip_remove
python ./data_augmentation/rename.py --input /data/data_augmentation/add_car_flip_remove --prefix add_car_flip_remove

# brightness and remove white line
python ./data_augmentation/brightness.py --input /data/nighttime_fixed --output /data/brightness
python ./data_augmentation/remove.py --input /data/brightness --output /data/data_augmentation/brightness_remove
python ./data_augmentation/rename.py --input data/data_augmentation/brightness_rename -prefix brightness_remove
