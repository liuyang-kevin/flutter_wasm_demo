# Flutter 桥 wasm Demo

1. wasm使用cmake组织项目，编译后输出 html，js，wasm文件
2. wasm+js 拷贝到example中的web主代码，用html加载wasm
3. flutter内部使用js桥到加载库

# 文档
* [camke组织wasm项目](docs/wasm环境配置.md)
* [flutter 使用 js](docs/x02_flutter添加wasm.md)

# WebRTC & MediaRecoder
* 录音、录像功能来自于浏览器本身，`navigator.mediaDevices.getUserMedia({audio:true}).then();`就可以拿到stream了
* WebRTC指的是实时网络传输问题。根媒体服务并不十分相关
[这里有一个webrtc点对点的视频通话的demo](docs/webrtc_demo/index.html)

# other links
* [从dart用http load wasm。](https://creativebracket.com/how-to-load-a-webassembly-file-in-dart-for-web/) 没实践。