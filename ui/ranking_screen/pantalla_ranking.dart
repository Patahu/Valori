



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorix/src/ui/ranking_screen/ranking_base.dart';

import '../../bloc/blocs_home/bloc_ranking/bloc.dart';

import 'package:flutter/material.dart';

class RankingBase extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        bottom: false,
        child: BlocProvider<RankingBloc>(
                create: (BuildContext context) => RankingBloc()..add(initRanking()),
                child: RankingScreen(),
            ),
      ),
    );
  }
}