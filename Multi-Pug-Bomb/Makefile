WORKSPACE = Multi-Pug-Bomb.xcworkspace
SCHEME = Multi-Pug-Bomb

.PHONY: all build ci clean pods test

all: ci

build:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) build

clean:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration $(CONFIGURATION) clean

test:
	xctool -workspace $(WORKSPACE) -scheme $(SCHEME) -configuration Debug test -sdk iphonesimulator

ci: CONFIGURATION = Debug
ci: pods clean test fui

pr: CONFIGURATION = Debug
pr: pod clean test fui

pods:
	gem install bundler
	bundle install
	rm -rf Pods
	pod install

pod:
	pod update

fui:
	bundle exec fui --path Artsy find
