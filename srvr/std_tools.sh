#Production tool for Build and test environment
rm -fr scripts
git clone git://gitorious.org/kciutils/kci-alpha.git >/dev/null
mv kci-alpha scripts
cd scripts
echo "Tools version:"`git rev-parse HEAD`
