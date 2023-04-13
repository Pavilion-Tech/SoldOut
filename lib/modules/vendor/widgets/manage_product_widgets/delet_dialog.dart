import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_cubit.dart';
import 'package:soldout/layout/vendor_layout/cubit/vendor_states.dart';
import 'package:soldout/shared/components/components.dart';

import '../../../../shared/components/constants.dart';

class DeletDialog extends StatelessWidget {
  DeletDialog({required this.id});

  int id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      content: Container(
        height: size!.height > 670 ? size!.height * .3:size!.height * .4,
        alignment: AlignmentDirectional.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(Icons.delete_forever, color: Colors.red, size: 50,),
            Text(
              tr('delete_sure'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 2,
                  fontSize: 16
              ),
            ),
            BlocConsumer<VendorCubit, VendorStates>(
              listener: (context, state) {},
              builder: (context, state) {
                return state is! DeleteProductLoadingState
                ?
                defaultButton(
                    onTap: () {
                      VendorCubit.get(context).deleteProduct(id, context);
                    },
                    text: tr('delete_product'))
                :const CircularProgressIndicator();
              },
            ),
            TextButton(
              onPressed: () {
                VendorCubit.get(context).nullingData();
                Navigator.pop(context);
              },
              child: Text(
                tr('discard'),
                style: const TextStyle(
                    fontWeight: FontWeight.w900, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
