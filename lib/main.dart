import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo LocoAr',
      home: Sensorama(),
    );
  }
}

class Sensorama extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ARKitSceneView(
        detectionImagesGroupName: 'AR Resources',
        onARKitViewCreated: (c) {
          c.onAddNodeForAnchor = (anchor) {
            if (anchor is ARKitImageAnchor) {
              final earthPosition = Vector3(
                  anchor.transform.getColumn(3).x,
                  anchor.transform.getColumn(3).y,
                  anchor.transform.getColumn(3).z);
              final node = ARKitNode(
                geometry: ARKitSphere(materials: [
                  ARKitMaterial(
                      diffuse:
                          ARKitMaterialProperty.image('assets/img/eath.jpg')),
                ], radius: 0.06),
                position: earthPosition,
              );
              c.add(node);
            }
          };
        },
      ),
    );
  }
}
