# this is executed in /etc/skel while chrooted, during the image build
# what's left inn /etc/skel after this is done will end up in /home
# when the image is booted

# get my econometrics stuff and use the version with correct links
git clone https://github.com/mcreel/Econometrics.git
mv Econometrics/econometrics_pelican.pdf Econometrics/econometrics.pdf

# fix missing symbols when using MPI with Octave
echo "alias mpirun='mpirun -x LD_PRELOAD=libmpi.so'" >> /etc/skel/.bashrc

# ANN with modification for Octave
if [ -d "/etc/skel/Econometrics" ]; then
	LOCATION="/etc/skel/Econometrics"
	############ ANN ############
	cd $LOCATION/MyOctaveFiles/Econometrics/NearestNeighbors/ann_1.1.2_creel
	echo "making ANN"
	make linux-g++
	mv bin/ann_sample /usr/local/bin
	install -d /etc/skel/Desktop
	mv /etc/skel/Econometrics/econometrics_pelican.pdf /etc/skel/Econometrics/econometrics.pdf
	rm /etc/skel/Econometrics/econometrics_local.pdf
fi

# build my octave .oct files
cd /etc/skel
if [ -d "/etc/skel/Econometrics" ]; then
	LOCATION="/etc/skel/Econometrics"
	############ my oct files ############
	cd $LOCATION/MyOctaveFiles/OctFiles
	echo "making my .cc files"
	make clean
	make all
	FILES="*.oct"
	for f in "$FILES"; do strip $f; done
	########### lbfgsb ###############
	cd $LOCATION/MyOctaveFiles/lbfgs
	octave --eval install_lbfgs
fi
cd ../

