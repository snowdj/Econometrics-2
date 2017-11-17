# this is executed in /etc/skel while chrooted, during the image build
# what's left inn /etc/skel after this is done will end up in /home
# when the image is booted

# get my econometrics stuff and use the version with correct links
git clone https://github.com/mcreel/Econometrics.git
mv Econometrics/econometrics_pelican.pdf Econometrics/econometrics.pdf

# get Julia, extract, and link executable into /usr/local/bin
wget https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.1-linux-x86_64.tar.gz
tar xfz julia-0.6.1-linux-x86_64.tar.gz
rm julia-0.6.1-linux-x86_64.tar.gz
mv julia* julia
ln -s julia/bin/julia /usr/local/bin
cd ../

