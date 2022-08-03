import 'package:chili/chili.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// 游戏摇杆
class GameRocker extends StatefulWidget {
  const GameRocker({required this.onChanged, Key? key}) : super(key: key);
  /// 方向回调事件
  final ValueChanged onChanged;

  @override
  State<GameRocker> createState() => _GameRockerState();
}

class _GameRockerState extends State<GameRocker> {

  // 按钮位置
  late Offset _offset;

  /// 方向
  String _direction = 'stop';

  late Offset _maxOffset;

  /// 原点（中心点）
  final Offset originOffset = Offset(60.0, 60.0);

  final GlobalKey _parentKey = GlobalKey();

  final GlobalKey _childKey = GlobalKey();

  /// 页面构建完成后获取有绑定key的组件信息
  void _setBoundary(_) {
    /// 获取父级信息
    final RenderBox parentRenderBox = _parentKey.currentContext?.findRenderObject() as RenderBox;
    /// 获取小按钮的信息
    final RenderBox renderBox = _childKey.currentContext?.findRenderObject() as RenderBox;

    try {
      final Size parentSize = parentRenderBox.size;
      final Size size = renderBox.size;

      setState(() {
        _maxOffset = Offset(
            parentSize.width - size.width,
            parentSize.height - size.height
        );
      });
    } catch (e) {
      print('catch: $e');
    }
  }

  /// 按钮移动更新事件
  void _updatePosiiton(Offset detail) {
    double dx = detail.dx + _offset.dx;
    double dy = detail.dy + _offset.dy;
    /// 控制偏移量，防止按钮超出父级
    if (dx <= 0 ) {
      dx = 0;
    } else if(dx > _maxOffset.dx) {
      dx = _maxOffset.dx;
    }
    if(dy <= 0) {
      dy = 0;
    }else if(dy >_maxOffset.dy) {
      dy = _maxOffset.dy;
    }

    if(dx < 20) { /// 左
      dy = 60;
      _direction = 'left';
    } else if(dx > 100) { /// 右
      _direction = 'right';
      dy = 60;
    }

    if(dy < 20) { // 前
      dx = 60;
      _direction = 'forward';
    } else if( dy > 100){ // 后
      dx = 60;
      _direction = 'back';
    }

    _offset = Offset(dx, dy);
    // print('方向：$_direction');
    widget.onChanged(_direction);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _offset = originOffset;
    WidgetsBinding.instance?.addPostFrameCallback(_setBoundary);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _parentKey,
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('img_play'.webp),
          fit: BoxFit.cover
        ),
        shape: BoxShape.circle
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            key: _childKey,
              left: _offset.dx,
              top: _offset.dy,
              child: GestureDetector(
                onPanUpdate: (DragUpdateDetails detail){
                  _updatePosiiton(detail.delta);
                },
                onPanEnd: (DragEndDetails endDetail){/// 松开手就复位
                  setState(() {
                    _offset = originOffset;
                  });
                  _direction = 'stop';
                },
                child: Image.asset('btn_play'.webp, width: 40,height: 40, fit: BoxFit.cover),
              )
          )
        ],
      ),
    );
  }
}

class CustomTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    //不，我不要失败，我要成功
    //super.rejectGesture(pointer);
    //宣布成功
    super.acceptGesture(pointer);
  }
}
