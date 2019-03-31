docker build -t flutter-test .
docker run -it -v $PWD/odroid:/root/odroid/ -w /root/ --rm flutter-test flutter create odroid
docker run -it -v $PWD/odroid:/root/odroid/ -w /root/odroid --rm flutter-test flutter test
