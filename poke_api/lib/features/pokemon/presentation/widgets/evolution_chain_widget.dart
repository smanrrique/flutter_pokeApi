import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_api/features/pokemon/domain/entities/evolution_stage.dart';

class EvolutionChainWidget extends StatelessWidget {
  const EvolutionChainWidget({super.key, required this.stages});

  final List<EvolutionStage> stages;

  @override
  Widget build(BuildContext context) {
    if (stages.isEmpty) {
      return const SizedBox.shrink();
    }
    if (stages.length == 1) {
      return Center(child: _StageTile(stage: stages.first));
    }

    final children = <Widget>[];
    for (var i = 0; i < stages.length; i++) {
      children.add(_StageTile(stage: stages[i]));
      if (i < stages.length - 1) {
        children.add(
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Icon(Icons.arrow_forward, color: Colors.grey, size: 18),
          ),
        );
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
    );
  }
}

class _StageTile extends StatelessWidget {
  const _StageTile({required this.stage});

  final EvolutionStage stage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.14;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: stage.imageUrl.isEmpty
              ? const Icon(Icons.image_not_supported, color: Colors.grey)
              : SvgPicture.network(
                  stage.imageUrl,
                  fit: BoxFit.contain,
                  placeholderBuilder: (_) => const Center(
                    child: SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
        ),
        Text(
          stage.name,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.025,
          ),
        ),
      ],
    );
  }
}
