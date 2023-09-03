
import 'package:counter_cubit/counter_cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () =>
                        BlocProvider.of<CounterCubit>(context).decrement(),
                    icon: const Icon(Icons.remove)),
                const SizedBox(
                  width: 3,
                ),
                // 
                BlocBuilder<CounterCubit, CounterState>(
                  builder: (context, state) {
                    return Text(
                      '${state.counterValue}',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
                const SizedBox(
                  width: 3,
                ),
                IconButton(
                    onPressed: () =>
                        BlocProvider.of<CounterCubit>(context).increment(),
                        
                    icon: const Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
