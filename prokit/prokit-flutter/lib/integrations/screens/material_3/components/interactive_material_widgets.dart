import 'package:flutter/material.dart' hide Actions;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/component_catalog.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/material_component_examples.dart';
import 'package:prokit_flutter/integrations/screens/material_3/components/misc_ui_components.dart' hide colDivider, smallSpacing;

class NavigationBars extends StatefulWidget {
  const NavigationBars({
    super.key,
    this.onSelectItem,
    required this.selectedIndex,
    required this.isExampleBar,
    this.isBadgeExample = false,
  });

  final void Function(int)? onSelectItem;
  final int selectedIndex;
  final bool isExampleBar;
  final bool isBadgeExample;

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  @override
  void didUpdateWidget(covariant NavigationBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {
    // App NavigationBar should get first focus.
    Widget navigationBar = Focus(
      autofocus: !(widget.isExampleBar || widget.isBadgeExample),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
          if (!widget.isExampleBar) widget.onSelectItem!(index);
        },
        destinations: widget.isExampleBar && widget.isBadgeExample
            ? barWithBadgeDestinations
            : widget.isExampleBar
                ? exampleBarDestinations
                : appBarDestinations,
      ),
    );

    if (widget.isExampleBar && widget.isBadgeExample) {
      navigationBar = ComponentDecoration(
        label: 'Badges',
        tooltipMessage: 'Use Badge or Badge.count',
        child: navigationBar,
      );
    } else if (widget.isExampleBar) {
      navigationBar = ComponentDecoration(
        label: 'Navigation bar',
        tooltipMessage: 'Use NavigationBar',
        child: navigationBar,
      );
    }

    return navigationBar;
  }
}

class IconToggleButtons extends StatefulWidget {
  const IconToggleButtons({super.key});

  @override
  State<IconToggleButtons> createState() => _IconToggleButtonsState();
}

class _IconToggleButtonsState extends State<IconToggleButtons> {
  bool standardSelected = false;
  bool filledSelected = false;
  bool tonalSelected = false;
  bool outlinedSelected = false;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Icon buttons',
      tooltipMessage: 'Use IconButton, IconButton.filled, IconButton.filledTonal, and IconButton.outlined',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            // Standard IconButton
            children: <Widget>[
              IconButton(
                isSelected: standardSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    standardSelected = !standardSelected;
                  });
                },
              ),
              colDivider,
              IconButton(
                isSelected: standardSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              // Filled IconButton
              IconButton.filled(
                isSelected: filledSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    filledSelected = !filledSelected;
                  });
                },
              ),
              colDivider,
              IconButton.filled(
                isSelected: filledSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              // Filled Tonal IconButton
              IconButton.filledTonal(
                isSelected: tonalSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    tonalSelected = !tonalSelected;
                  });
                },
              ),
              colDivider,
              IconButton.filledTonal(
                isSelected: tonalSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              // Outlined IconButton
              IconButton.outlined(
                isSelected: outlinedSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: () {
                  setState(() {
                    outlinedSelected = !outlinedSelected;
                  });
                },
              ),
              colDivider,
              IconButton.outlined(
                isSelected: outlinedSelected,
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                onPressed: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Chips extends StatefulWidget {
  const Chips({super.key});

  @override
  State<Chips> createState() => _ChipsState();
}

class _ChipsState extends State<Chips> {
  bool isFiltered = true;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Chips',
      tooltipMessage: 'Use ActionChip, FilterChip, or InputChip. \nActionChip can also be used for suggestion chip',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Wrap(
            spacing: smallSpacing,
            runSpacing: smallSpacing,
            children: <Widget>[
              ActionChip(
                label: const Text('Assist'),
                avatar: const Icon(Icons.event),
                onPressed: () {},
              ),
              FilterChip(
                label: const Text('Filter'),
                selected: isFiltered,
                onSelected: (selected) {
                  setState(() => isFiltered = selected);
                },
              ),
              InputChip(
                label: const Text('Input'),
                onPressed: () {},
                onDeleted: () {},
              ),
              ActionChip(label: const Text('Suggestion'), onPressed: () {}),
            ],
          ),
          colDivider,
          Wrap(
            spacing: smallSpacing,
            runSpacing: smallSpacing,
            children: <Widget>[
              const ActionChip(
                label: Text('Assist'),
                avatar: Icon(Icons.event),
              ),
              FilterChip(
                label: const Text('Filter'),
                selected: isFiltered,
                onSelected: null,
              ),
              InputChip(
                label: const Text('Input'),
                onDeleted: () {},
                isEnabled: false,
              ),
              const ActionChip(label: Text('Suggestion')),
            ],
          ),
        ],
      ),
    );
  }
}

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? selectedDate;
  final DateTime _firstDate = DateTime(DateTime.now().year - 2);
  final DateTime _lastDate = DateTime(DateTime.now().year + 1);

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Date picker',
      tooltipMessage: 'Use showDatePicker',
      child: TextButton.icon(
        onPressed: () async {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: _firstDate,
            lastDate: _lastDate,
          );
          setState(() {
            selectedDate = date;
            if (selectedDate != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Selected Date: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}',
                  ),
                ),
              );
            }
          });
        },
        icon: const Icon(Icons.calendar_month),
        label: const Text(
          'Show date picker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Time picker',
      tooltipMessage: 'Use showTimePicker',
      child: TextButton.icon(
        onPressed: () async {
          final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: selectedTime ?? TimeOfDay.now(),
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(alwaysUse24HourFormat: true),
                child: child!,
              );
            },
          );
          setState(() {
            selectedTime = time;
            if (selectedTime != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Selected time: ${selectedTime!.format(context)}',
                  ),
                ),
              );
            }
          });
        },
        icon: const Icon(Icons.schedule),
        label: const Text(
          'Show time picker',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class SegmentedButtons extends StatelessWidget {
  const SegmentedButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentDecoration(
      label: 'Segmented buttons',
      tooltipMessage: 'Use SegmentedButton<T>',
      child: Column(
        children: <Widget>[SingleChoice(), colDivider, MultipleChoice()],
      ),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
          value: Calendar.day,
          label: Text('Day'),
          icon: Icon(Icons.calendar_view_day),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.week,
          label: Text('Week'),
          icon: Icon(Icons.calendar_view_week),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.month,
          label: Text('Month'),
          icon: Icon(Icons.calendar_view_month),
        ),
        ButtonSegment<Calendar>(
          value: Calendar.year,
          label: Text('Year'),
          icon: Icon(Icons.calendar_today),
        ),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

enum Sizes { extraSmall, small, medium, large, extraLarge }

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sizes>(
      segments: const <ButtonSegment<Sizes>>[
        ButtonSegment<Sizes>(value: Sizes.extraSmall, label: Text('XS')),
        ButtonSegment<Sizes>(value: Sizes.small, label: Text('S')),
        ButtonSegment<Sizes>(value: Sizes.medium, label: Text('M')),
        ButtonSegment<Sizes>(value: Sizes.large, label: Text('L')),
        ButtonSegment<Sizes>(value: Sizes.extraLarge, label: Text('XL')),
      ],
      selected: selection,
      onSelectionChanged: (newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}

class SnackBarSection extends StatelessWidget {
  const SnackBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentDecoration(
      label: 'Snackbar',
      tooltipMessage: 'Use ScaffoldMessenger.of(context).showSnackBar with SnackBar',
      child: TextButton(
        onPressed: () {
          final snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            width: 400.0,
            content: const Text('This is a snackbar'),
            action: SnackBarAction(label: 'Close', onPressed: () {}),
          );

          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text(
          'Show snackbar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
