import 'package:flutter/material.dart';
import 'package:flutter_awesome_select/flutter_awesome_select.dart';

class RemovalType {
  static RemovalType get best => const RemovalType.internal("최우선키워드", "best");
  static RemovalType get include => const RemovalType.internal("포함", "include");
  static RemovalType get exclude => const RemovalType.internal("제외", "exclude");
  static List<RemovalType> get values => [
        RemovalType.include,
        RemovalType.exclude,
        RemovalType.best,
      ];

  final String display;
  final String value;

  const RemovalType.internal(this.display, this.value);
}

class SelectRemovalType extends StatefulWidget {
  const SelectRemovalType({Key? key}) : super(key: key);

  @override
  _SelectRemovalTypeState createState() => _SelectRemovalTypeState();
}

class _SelectRemovalTypeState extends State<SelectRemovalType> {
  String? typeValue = RemovalType.include.value;

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String?>.single(
      selectedValue: typeValue,
      choiceItems: RemovalType.values
          .map((type) =>
              S2Choice<String>(title: type.display, value: type.value))
          .toList(),
      onChange: (selected) => setState(() => typeValue = selected.value),
      modalType: S2ModalType.popupDialog,
      tileBuilder: (context, state) {
        //state.title이 위에서 지정한 title을 의미한다.
        //state.selected가 위에서 fruitList로 지정한 S2Choice를 의미한다.
        // --즉, state.selected?.value, state.selected?.title을 활용할 수 있다.
        //state.showModal이라는 함수를 통해 modalType에 대한 기능을 실행한다.
        return ListTile(
          title: Text(state.title ?? ''),
          subtitle: Text(
            state.selected?.title ?? "",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: state.showModal,
        );
      },
    );
  }
}
