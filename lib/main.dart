import 'dart:async';

import 'dart:math';

import 'dart:typed_data';



import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



void main() {

  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AudiometerApp());

}



// ============================================================

// APP

// ============================================================



class AudiometerApp extends StatelessWidget {

  const AudiometerApp({super.key});



  @override

  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Mobile Audiometer',

      theme: ThemeData(

        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(

          seedColor: Colors.blue,

        ),

        scaffoldBackgroundColor: const Color(0xFFF5F9FC),

      ),

      home: const HomeScreen(),

    );

  }

}



// ============================================================

// DATA MODEL

// ============================================================



class HearingMeasurement {

  final String ear;

  final int frequency;

  final int level;

  final bool heard;



  const HearingMeasurement({

    required this.ear,

    required this.frequency,

    required this.level,

    required this.heard,

  });

}



// ============================================================

// HOME SCREEN

// ============================================================



class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(

          'Mobile Audiometer',

          style: TextStyle(fontWeight: FontWeight.bold),

        ),

        centerTitle: true,

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              const SizedBox(height: 20),



              Center(

                child: Container(

                  height: 110,

                  width: 110,

                  decoration: BoxDecoration(

                    color: Colors.blue.shade100,

                    shape: BoxShape.circle,

                  ),

                  child: Icon(

                    Icons.hearing,

                    size: 60,

                    color: Colors.blue.shade700,

                  ),

                ),

              ),



              const SizedBox(height: 25),



              const Text(

                'Hearing Screening',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 10),



              Text(

                'Mobile-based hearing screening for children',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 16,

                  color: Colors.grey.shade700,

                ),

              ),



              const SizedBox(height: 35),



              _MenuCard(

                icon: Icons.person_add,

                title: 'New Screening',

                subtitle: 'Register a child and start a hearing test',

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => const ChildRegistrationScreen(),

                    ),

                  );

                },

              ),



              const SizedBox(height: 15),



              _MenuCard(

                icon: Icons.tune,

                title: 'Calibration',

                subtitle: 'Check phone and earphone audio output',

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => const CalibrationScreen(),

                    ),

                  );

                },

              ),



              const SizedBox(height: 15),



              _MenuCard(

                icon: Icons.assessment,

                title: 'Screening Information',

                subtitle: 'Understand how the hearing screening works',

                onTap: () {

                  showDialog(

                    context: context,

                    builder: (_) => AlertDialog(

                      title: const Text('About the screening'),

                      content: const Text(

                        'The application presents controlled test tones '

                        'through connected earphones and records whether '

                        'the child responds to each test stimulus.\n\n'

                        'The system is intended for screening and referral '

                        'support, not medical diagnosis.',

                      ),

                      actions: [

                        TextButton(

                          onPressed: () => Navigator.pop(context),

                          child: const Text('OK'),

                        ),

                      ],

                    ),

                  );

                },

              ),



              const SizedBox(height: 30),



              Container(

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(

                  color: Colors.orange.shade50,

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(

                    color: Colors.orange.shade200,

                  ),

                ),

                child: const Row(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Icon(

                      Icons.info_outline,

                      color: Colors.orange,

                    ),

                    SizedBox(width: 10),

                    Expanded(

                      child: Text(

                        'This application is intended for hearing '

                        'screening and referral support. It is not '

                        'intended to provide a medical diagnosis.',

                      ),

                    ),

                  ],

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}



// ============================================================

// MENU CARD

// ============================================================



class _MenuCard extends StatelessWidget {

  final IconData icon;

  final String title;

  final String subtitle;

  final VoidCallback onTap;



  const _MenuCard({

    required this.icon,

    required this.title,

    required this.subtitle,

    required this.onTap,

  });



  @override

  Widget build(BuildContext context) {

    return Card(

      elevation: 2,

      child: InkWell(

        borderRadius: BorderRadius.circular(12),

        onTap: onTap,

        child: Padding(

          padding: const EdgeInsets.all(18),

          child: Row(

            children: [

              Container(

                height: 55,

                width: 55,

                decoration: BoxDecoration(

                  color: Colors.blue.shade50,

                  borderRadius: BorderRadius.circular(12),

                ),

                child: Icon(

                  icon,

                  color: Colors.blue.shade700,

                  size: 30,

                ),

              ),

              const SizedBox(width: 16),

              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(

                      title,

                      style: const TextStyle(

                        fontSize: 17,

                        fontWeight: FontWeight.bold,

                      ),

                    ),

                    const SizedBox(height: 4),

                    Text(

                      subtitle,

                      style: TextStyle(

                        color: Colors.grey.shade600,

                      ),

                    ),

                  ],

                ),

              ),

              const Icon(

                Icons.arrow_forward_ios,

                size: 18,

              ),

            ],

          ),

        ),

      ),

    );

  }

}



// ============================================================

// CHILD REGISTRATION

// ============================================================



class ChildRegistrationScreen extends StatefulWidget {

  const ChildRegistrationScreen({super.key});



  @override

  State<ChildRegistrationScreen> createState() =>

      _ChildRegistrationScreenState();

}



class _ChildRegistrationScreenState

    extends State<ChildRegistrationScreen> {

  final formKey = GlobalKey<FormState>();



  final nameController = TextEditingController();

  final ageController = TextEditingController();

  final schoolController = TextEditingController();

  final classController = TextEditingController();



  String gender = 'Male';



  @override

  void dispose() {

    nameController.dispose();

    ageController.dispose();

    schoolController.dispose();

    classController.dispose();

    super.dispose();

  }



  void continueToCalibration() {

    if (!formKey.currentState!.validate()) {

      return;

    }



    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => CalibrationScreen(

          childName: nameController.text.trim(),

          childAge: ageController.text.trim(),

          gender: gender,

        ),

      ),

    );

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Child Registration'),

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Form(

            key: formKey,

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [

                const Text(

                  'Child Information',

                  style: TextStyle(

                    fontSize: 24,

                    fontWeight: FontWeight.bold,

                  ),

                ),



                const SizedBox(height: 8),



                Text(

                  'Enter the child details before starting screening.',

                  style: TextStyle(

                    color: Colors.grey.shade600,

                  ),

                ),



                const SizedBox(height: 25),



                TextFormField(

                  controller: nameController,

                  decoration: const InputDecoration(

                    labelText: 'Child Name',

                    prefixIcon: Icon(Icons.person),

                    border: OutlineInputBorder(),

                  ),

                  validator: (value) {

                    if (value == null || value.trim().isEmpty) {

                      return 'Please enter the child name';

                    }

                    return null;

                  },

                ),



                const SizedBox(height: 16),



                TextFormField(

                  controller: ageController,

                  keyboardType: TextInputType.number,

                  decoration: const InputDecoration(

                    labelText: 'Age',

                    prefixIcon: Icon(Icons.cake),

                    border: OutlineInputBorder(),

                  ),

                  validator: (value) {

                    if (value == null || value.trim().isEmpty) {

                      return 'Please enter the age';

                    }



                    final age = int.tryParse(value);



                    if (age == null || age < 1 || age > 18) {

                      return 'Enter a valid age';

                    }



                    return null;

                  },

                ),



                const SizedBox(height: 16),



                DropdownButtonFormField<String>(

                  initialValue: gender,

                  decoration: const InputDecoration(

                    labelText: 'Gender',

                    prefixIcon: Icon(Icons.people),

                    border: OutlineInputBorder(),

                  ),

                  items: const [

                    DropdownMenuItem(

                      value: 'Male',

                      child: Text('Male'),

                    ),

                    DropdownMenuItem(

                      value: 'Female',

                      child: Text('Female'),

                    ),

                    DropdownMenuItem(

                      value: 'Other',

                      child: Text('Other'),

                    ),

                  ],

                  onChanged: (value) {

                    if (value != null) {

                      setState(() {

                        gender = value;

                      });

                    }

                  },

                ),



                const SizedBox(height: 16),



                TextFormField(

                  controller: schoolController,

                  decoration: const InputDecoration(

                    labelText: 'School Name',

                    prefixIcon: Icon(Icons.school),

                    border: OutlineInputBorder(),

                  ),

                ),



                const SizedBox(height: 16),



                TextFormField(

                  controller: classController,

                  decoration: const InputDecoration(

                    labelText: 'Class / Grade',

                    prefixIcon: Icon(Icons.class_),

                    border: OutlineInputBorder(),

                  ),

                ),



                const SizedBox(height: 30),



                FilledButton.icon(

                  onPressed: continueToCalibration,

                  icon: const Icon(Icons.arrow_forward),

                  label: const Padding(

                    padding: EdgeInsets.all(14),

                    child: Text(

                      'Continue to Calibration',

                      style: TextStyle(fontSize: 16),

                    ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}



// ============================================================

// CALIBRATION

// ============================================================



class CalibrationScreen extends StatefulWidget {

  final String? childName;

  final String? childAge;

  final String? gender;



  const CalibrationScreen({

    super.key,

    this.childName,

    this.childAge,

    this.gender,

  });



  @override

  State<CalibrationScreen> createState() =>

      _CalibrationScreenState();

}



class _CalibrationScreenState

    extends State<CalibrationScreen> {

  final AudioPlayer calibrationPlayer = AudioPlayer();



  bool earphoneConnected = false;

  bool audioChecked = false;

  bool isTestingAudio = false;



  @override

  void dispose() {

    calibrationPlayer.dispose();

    super.dispose();

  }



  // ----------------------------------------------------------

  // PLAY CALIBRATION TEST SOUND

  // ----------------------------------------------------------



  Future<void> testAudioOutput() async {

    if (isTestingAudio) return;



    setState(() {

      isTestingAudio = true;

    });



    try {

      await calibrationPlayer.stop();



      await calibrationPlayer.setVolume(1.0);

      await calibrationPlayer.setReleaseMode(

        ReleaseMode.stop,

      );



      final bytes = generateSineWaveWav(

        frequency: 1000,

        durationSeconds: 1.5,

        amplitude: 0.30,

      );



      await calibrationPlayer.play(

        BytesSource(bytes),

        volume: 1.0,

      );



      await Future.delayed(

        const Duration(milliseconds: 1600),

      );



      if (mounted) {

        setState(() {

          audioChecked = true;

        });



        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(

            content: Text(

              'Audio test completed. If you heard the tone, audio output is working.',

            ),

          ),

        );

      }

    } catch (e) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content: Text(

              'Audio test failed: $e',

            ),

          ),

        );

      }

    } finally {

      if (mounted) {

        setState(() {

          isTestingAudio = false;

        });

      }

    }

  }



  // ----------------------------------------------------------

  // START HEARING TEST

  // ----------------------------------------------------------



  void startTest() {

    if (!earphoneConnected) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(

            'Please confirm that the earphones are connected.',

          ),

        ),

      );

      return;

    }



    if (!audioChecked) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(

            'Please run the audio test first.',

          ),

        ),

      );

      return;

    }



    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => HearingTestScreen(

          childName: widget.childName ?? 'Test Child',

        ),

      ),

    );

  }



  @override

  Widget build(BuildContext context) {

    final ready = earphoneConnected && audioChecked;



    return Scaffold(

      appBar: AppBar(

        title: const Text('Calibration'),

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              const SizedBox(height: 10),



              const Icon(

                Icons.tune,

                size: 75,

                color: Colors.blue,

              ),



              const SizedBox(height: 15),



              const Text(

                'Device Calibration',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 28,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 10),



              Text(

                'Before performing a screening, the phone and '

                'earphones should be checked using an appropriate '

                'reference procedure.',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 16,

                  color: Colors.grey.shade700,

                ),

              ),



              const SizedBox(height: 30),



              // ------------------------------------------------

              // STEP 1

              // ------------------------------------------------



              _CalibrationCard(

                number: '1',

                icon: Icons.headphones,

                title: 'Connect earphones',

                description:

                    'Connect the calibrated earphones to the phone.',

                completed: earphoneConnected,

                onTap: () {

                  setState(() {

                    earphoneConnected = !earphoneConnected;



                    if (!earphoneConnected) {

                      audioChecked = false;

                    }

                  });

                },

              ),



              const SizedBox(height: 15),



              // ------------------------------------------------

              // STEP 2

              // ------------------------------------------------



              _CalibrationCard(

                number: '2',

                icon: Icons.volume_up,

                title: 'Check audio output',

                description:

                    'Play a test tone and verify that the audio output works.',

                completed: audioChecked,

                enabled: earphoneConnected,

                onTap: earphoneConnected

                    ? testAudioOutput

                    : () {

                        ScaffoldMessenger.of(context).showSnackBar(

                          const SnackBar(

                            content: Text(

                              'Connect the earphones first.',

                            ),

                          ),

                        );

                      },

              ),



              const SizedBox(height: 15),



              // ------------------------------------------------

              // TEST AUDIO BUTTON

              // ------------------------------------------------



              OutlinedButton.icon(

                onPressed: !earphoneConnected || isTestingAudio

                    ? null

                    : testAudioOutput,

                icon: isTestingAudio

                    ? const SizedBox(

                        height: 18,

                        width: 18,

                        child: CircularProgressIndicator(

                          strokeWidth: 2,

                        ),

                      )

                    : const Icon(Icons.volume_up),

                label: Padding(

                  padding: const EdgeInsets.all(12),

                  child: Text(

                    isTestingAudio

                        ? 'Playing Test Tone...'

                        : 'Play Test Audio',

                    style: const TextStyle(

                      fontSize: 16,

                    ),

                  ),

                ),

              ),



              const SizedBox(height: 20),



              // ------------------------------------------------

              // STEP 3

              // ------------------------------------------------



              _CalibrationCard(

                number: '3',

                icon: Icons.check_circle,

                title: 'Calibration ready',

                description:

                    ready

                        ? 'Phone and audio output are ready for the hearing test.'

                        : 'Complete the previous steps first.',

                completed: ready,

                enabled: ready,

                onTap: ready

                    ? () {

                        ScaffoldMessenger.of(context).showSnackBar(

                          const SnackBar(

                            content: Text(

                              'Calibration setup completed.',

                            ),

                          ),

                        );

                      }

                    : () {},

              ),



              const SizedBox(height: 20),



              // ------------------------------------------------

              // WARNING

              // ------------------------------------------------



              Container(

                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(

                  color: Colors.amber.shade50,

                  borderRadius: BorderRadius.circular(12),

                  border: Border.all(

                    color: Colors.amber.shade300,

                  ),

                ),

                child: const Row(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Icon(

                      Icons.warning_amber,

                      color: Colors.amber,

                    ),

                    SizedBox(width: 10),

                    Expanded(

                      child: Text(

                        'Software volume is not the same as clinical '

                        'dB HL. The phone + earphone combination must '

                        'be calibrated against a validated reference '

                        'before clinical interpretation.',

                      ),

                    ),

                  ],

                ),

              ),



              const SizedBox(height: 30),



              // ------------------------------------------------

              // START TEST

              // ------------------------------------------------



              FilledButton.icon(

                onPressed: startTest,

                icon: const Icon(Icons.play_arrow),

                label: const Padding(

                  padding: EdgeInsets.all(14),

                  child: Text(

                    'Start Hearing Test',

                    style: TextStyle(fontSize: 17),

                  ),

                ),

              ),



              const SizedBox(height: 10),



              Text(

                ready

                    ? '✓ Setup complete'

                    : 'Complete the setup steps before starting',

                textAlign: TextAlign.center,

                style: TextStyle(

                  color: ready ? Colors.green : Colors.grey.shade600,

                  fontWeight: FontWeight.w600,

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}



// ============================================================

// CALIBRATION CARD

// ============================================================



class _CalibrationCard extends StatelessWidget {

  final String number;

  final IconData icon;

  final String title;

  final String description;

  final bool completed;

  final bool enabled;

  final VoidCallback onTap;



  const _CalibrationCard({

    required this.number,

    required this.icon,

    required this.title,

    required this.description,

    required this.completed,

    this.enabled = true,

    required this.onTap,

  });



  @override

  Widget build(BuildContext context) {

    return Card(

      elevation: 2,

      child: InkWell(

        borderRadius: BorderRadius.circular(12),

        onTap: enabled ? onTap : null,

        child: Padding(

          padding: const EdgeInsets.all(16),

          child: Row(

            children: [

              Container(

                height: 50,

                width: 50,

                decoration: BoxDecoration(

                  color: completed

                      ? Colors.green.shade100

                      : Colors.blue.shade100,

                  shape: BoxShape.circle,

                ),

                child: Center(

                  child: completed

                      ? const Icon(

                          Icons.check,

                          color: Colors.green,

                        )

                      : Text(

                          number,

                          style: const TextStyle(

                            fontSize: 20,

                            fontWeight: FontWeight.bold,

                            color: Colors.blue,

                          ),

                        ),

                ),

              ),



              const SizedBox(width: 15),



              Expanded(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      children: [

                        Icon(

                          icon,

                          size: 20,

                          color: enabled

                              ? Colors.blue

                              : Colors.grey,

                        ),

                        const SizedBox(width: 7),

                        Expanded(

                          child: Text(

                            title,

                            style: TextStyle(

                              fontSize: 17,

                              fontWeight: FontWeight.bold,

                              color: enabled

                                  ? Colors.black87

                                  : Colors.grey,

                            ),

                          ),

                        ),

                      ],

                    ),



                    const SizedBox(height: 5),



                    Text(

                      description,

                      style: TextStyle(

                        color: enabled

                            ? Colors.grey.shade700

                            : Colors.grey,

                      ),

                    ),

                  ],

                ),

              ),



              const SizedBox(width: 5),



              Icon(

                completed

                    ? Icons.check_circle

                    : Icons.arrow_forward_ios,

                size: 20,

                color: completed

                    ? Colors.green

                    : Colors.grey,

              ),

            ],

          ),

        ),

      ),

    );

  }

}



// ============================================================

// HEARING TEST

// ============================================================



class HearingTestScreen extends StatefulWidget {

  final String childName;



  const HearingTestScreen({

    super.key,

    required this.childName,

  });



  @override

  State<HearingTestScreen> createState() =>

      _HearingTestScreenState();

}



class _HearingTestScreenState

    extends State<HearingTestScreen> {

  final AudioPlayer player = AudioPlayer();



  final frequencies = const [

    250,

    500,

    1000,

    2000,

    4000,

    8000,

  ];



  final levels = const [

    10,

    20,

    30,

    40,

    50,

    60,

  ];



  String selectedEar = 'Left Ear';

  int selectedFrequency = 1000;

  int selectedLevel = 30;



  bool isPlaying = false;



  final List<HearingMeasurement> measurements = [];



  @override

  void initState() {

    super.initState();



    player.setVolume(1.0);

    player.setReleaseMode(ReleaseMode.stop);

  }



  @override

  void dispose() {

    player.dispose();

    super.dispose();

  }



  // ----------------------------------------------------------

  // PLAY TONE

  // ----------------------------------------------------------



  Future<void> playTone() async {

    if (isPlaying) return;



    setState(() {

      isPlaying = true;

    });



    try {

      await player.stop();



      await player.setVolume(1.0);



      final wavBytes = generateSineWaveWav(

        frequency: selectedFrequency,

        durationSeconds: 1.5,

        amplitude: selectedLevel / 100.0,

      );



      await player.play(

        BytesSource(wavBytes),

        volume: 1.0,

      );



      await Future.delayed(

        const Duration(milliseconds: 1600),

      );

    } catch (e) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          SnackBar(

            content: Text(

              'Unable to play tone: $e',

            ),

          ),

        );

      }

    } finally {

      if (mounted) {

        setState(() {

          isPlaying = false;

        });

      }

    }

  }



  // ----------------------------------------------------------

  // STOP

  // ----------------------------------------------------------



  Future<void> stopTone() async {

    await player.stop();



    if (mounted) {

      setState(() {

        isPlaying = false;

      });

    }

  }



  // ----------------------------------------------------------

  // RECORD RESPONSE

  // ----------------------------------------------------------



  void recordResponse(bool heard) {

    measurements.removeWhere(

      (measurement) =>

          measurement.ear == selectedEar &&

          measurement.frequency == selectedFrequency,

    );



    measurements.add(

      HearingMeasurement(

        ear: selectedEar,

        frequency: selectedFrequency,

        level: selectedLevel,

        heard: heard,

      ),

    );



    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(

          heard

              ? 'Response recorded: Heard'

              : 'Response recorded: Not Heard',

        ),

      ),

    );

  }



  // ----------------------------------------------------------

  // RESULTS

  // ----------------------------------------------------------



  void openResults() {

    if (measurements.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(

            'Record at least one response first.',

          ),

        ),

      );

      return;

    }



    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => ResultScreen(

          childName: widget.childName,

          measurements: List.from(measurements),

        ),

      ),

    );

  }



  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text('Hearing Test'),

        actions: [

          IconButton(

            tooltip: 'Results',

            onPressed: openResults,

            icon: const Icon(Icons.assessment),

          ),

        ],

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(18),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              Text(

                'Child: ${widget.childName}',

                style: const TextStyle(

                  fontSize: 19,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 20),



              const Text(

                'Test Ear',

                style: TextStyle(

                  fontSize: 17,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 8),



              SegmentedButton<String>(

                segments: const [

                  ButtonSegment<String>(

                    value: 'Left Ear',

                    label: Text('Left Ear'),

                    icon: Icon(Icons.hearing),

                  ),

                  ButtonSegment<String>(

                    value: 'Right Ear',

                    label: Text('Right Ear'),

                    icon: Icon(Icons.hearing),

                  ),

                ],

                selected: {selectedEar},

                onSelectionChanged: (value) {

                  setState(() {

                    selectedEar = value.first;

                  });

                },

              ),



              const SizedBox(height: 22),



              const Text(

                'Select Frequency',

                style: TextStyle(

                  fontSize: 17,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 10),



              Wrap(

                spacing: 8,

                runSpacing: 8,

                children: frequencies.map((frequency) {

                  return ChoiceChip(

                    label: Text(

                      frequency >= 1000

                          ? '${frequency ~/ 1000} kHz'

                          : '$frequency Hz',

                    ),

                    selected:

                        selectedFrequency == frequency,

                    onSelected: (_) {

                      setState(() {

                        selectedFrequency = frequency;

                      });

                    },

                  );

                }).toList(),

              ),



              const SizedBox(height: 22),



              const Text(

                'Test Level',

                style: TextStyle(

                  fontSize: 17,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 5),



              Text(

                '$selectedLevel test level',

                style: TextStyle(

                  color: Colors.grey.shade700,

                ),

              ),



              Slider(

                value: selectedLevel.toDouble(),

                min: 10,

                max: 60,

                divisions: 5,

                label: '$selectedLevel',

                onChanged: (value) {

                  setState(() {

                    selectedLevel = value.round();

                  });

                },

              ),



              Wrap(

                spacing: 8,

                children: levels.map((level) {

                  return ChoiceChip(

                    label: Text('$level'),

                    selected: selectedLevel == level,

                    onSelected: (_) {

                      setState(() {

                        selectedLevel = level;

                      });

                    },

                  );

                }).toList(),

              ),



              const SizedBox(height: 25),



              Card(

                elevation: 2,

                child: Padding(

                  padding: const EdgeInsets.all(22),

                  child: Column(

                    children: [

                      Icon(

                        isPlaying

                            ? Icons.volume_up

                            : Icons.hearing,

                        size: 60,

                        color: isPlaying

                            ? Colors.green

                            : Colors.blue,

                      ),



                      const SizedBox(height: 10),



                      Text(

                        '$selectedFrequency Hz',

                        style: const TextStyle(

                          fontSize: 30,

                          fontWeight: FontWeight.bold,

                        ),

                      ),



                      Text(

                        selectedEar,

                        style: TextStyle(

                          color: Colors.grey.shade700,

                        ),

                      ),



                      const SizedBox(height: 5),



                      Text(

                        'Test Level: $selectedLevel',

                        style: TextStyle(

                          color: Colors.grey.shade600,

                        ),

                      ),

                    ],

                  ),

                ),

              ),



              const SizedBox(height: 18),



              if (!isPlaying)

                FilledButton.icon(

                  onPressed: playTone,

                  icon: const Icon(Icons.play_arrow),

                  label: const Padding(

                    padding: EdgeInsets.all(14),

                    child: Text(

                      'Play Test Tone',

                      style: TextStyle(fontSize: 17),

                    ),

                  ),

                )

              else

                FilledButton.icon(

                  onPressed: stopTone,

                  icon: const Icon(Icons.stop),

                  label: const Padding(

                    padding: EdgeInsets.all(14),

                    child: Text(

                      'Stop Tone',

                      style: TextStyle(fontSize: 17),

                    ),

                  ),

                ),



              const SizedBox(height: 20),



              const Text(

                'Did the child hear the tone?',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 10),



              Row(

                children: [

                  Expanded(

                    child: FilledButton.icon(

                      onPressed: isPlaying

                          ? null

                          : () => recordResponse(true),

                      icon: const Icon(Icons.check),

                      label: const Text('Heard'),

                    ),

                  ),



                  const SizedBox(width: 10),



                  Expanded(

                    child: OutlinedButton.icon(

                      onPressed: isPlaying

                          ? null

                          : () => recordResponse(false),

                      icon: const Icon(Icons.close),

                      label: const Text('Not Heard'),

                    ),

                  ),

                ],

              ),



              const SizedBox(height: 20),



              Text(

                'Recorded responses: ${measurements.length}',

                textAlign: TextAlign.center,

                style: TextStyle(

                  color: Colors.grey.shade700,

                ),

              ),



              const SizedBox(height: 10),



              OutlinedButton.icon(

                onPressed: openResults,

                icon: const Icon(Icons.assessment),

                label: const Text(

                  'View Audiogram / Results',

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}



// ============================================================

// WAV GENERATOR

// ============================================================



Uint8List generateSineWaveWav({

  required int frequency,

  required double durationSeconds,

  required double amplitude,

}) {

  const sampleRate = 44100;

  const channels = 1;

  const bitsPerSample = 16;



  final sampleCount =

      (sampleRate * durationSeconds).round();



  const bytesPerSample = 2;



  final dataSize =

      sampleCount * channels * bytesPerSample;



  final fileSize = 44 + dataSize;



  final buffer = ByteData(fileSize);



  // RIFF

  _writeString(buffer, 0, 'RIFF');



  buffer.setUint32(

    4,

    fileSize - 8,

    Endian.little,

  );



  _writeString(buffer, 8, 'WAVE');



  // fmt

  _writeString(buffer, 12, 'fmt ');



  buffer.setUint32(

    16,

    16,

    Endian.little,

  );



  buffer.setUint16(

    20,

    1,

    Endian.little,

  );



  buffer.setUint16(

    22,

    channels,

    Endian.little,

  );



  buffer.setUint32(

    24,

    sampleRate,

    Endian.little,

  );



  buffer.setUint32(

    28,

    sampleRate *

        channels *

        bytesPerSample,

    Endian.little,

  );



  buffer.setUint16(

    32,

    channels * bytesPerSample,

    Endian.little,

  );



  buffer.setUint16(

    34,

    bitsPerSample,

    Endian.little,

  );



  // data

  _writeString(buffer, 36, 'data');



  buffer.setUint32(

    40,

    dataSize,

    Endian.little,

  );



  final safeAmplitude =

      amplitude.clamp(0.0, 1.0);



  final maxAmplitude =

      32767 * safeAmplitude;



  const fadeSamples = 1000;



  for (int i = 0; i < sampleCount; i++) {

    final time = i / sampleRate;



    double envelope = 1.0;



    if (i < fadeSamples) {

      envelope = i / fadeSamples;

    } else if (i > sampleCount - fadeSamples) {

      envelope =

          (sampleCount - i) / fadeSamples;

    }



    final sample =

        sin(2 * pi * frequency * time) *

            maxAmplitude *

            envelope;



    final value = sample

        .round()

        .clamp(-32768, 32767)

        .toInt();



    buffer.setInt16(

      44 + i * 2,

      value,

      Endian.little,

    );

  }



  return buffer.buffer.asUint8List();

}



void _writeString(

  ByteData data,

  int offset,

  String value,

) {

  for (int i = 0; i < value.length; i++) {

    data.setUint8(

      offset + i,

      value.codeUnitAt(i),

    );

  }

}



// ============================================================

// RESULT SCREEN

// ============================================================



class ResultScreen extends StatelessWidget {

  final String childName;

  final List<HearingMeasurement> measurements;



  const ResultScreen({

    super.key,

    required this.childName,

    required this.measurements,

  });



  List<HearingMeasurement> get leftMeasurements {

    return measurements

        .where((m) => m.ear == 'Left Ear')

        .toList();

  }



  List<HearingMeasurement> get rightMeasurements {

    return measurements

        .where((m) => m.ear == 'Right Ear')

        .toList();

  }



  String screeningStatus(

    List<HearingMeasurement> data,

  ) {

    if (data.isEmpty) {

      return 'NO DATA';

    }



    final notHeardCount =

        data.where((m) => !m.heard).length;



    if (notHeardCount == 0) {

      return 'PASS';

    }



    return 'REFER';

  }



  @override

  Widget build(BuildContext context) {

    final leftStatus =

        screeningStatus(leftMeasurements);



    final rightStatus =

        screeningStatus(rightMeasurements);



    return Scaffold(

      appBar: AppBar(

        title: const Text('Screening Result'),

      ),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              const Icon(

                Icons.assessment,

                size: 75,

                color: Colors.blue,

              ),



              const SizedBox(height: 12),



              Text(

                'Child: $childName',

                textAlign: TextAlign.center,

                style: const TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 20),



              Card(

                child: Padding(

                  padding: const EdgeInsets.all(18),

                  child: Column(

                    children: [

                      const Text(

                        'SCREENING STATUS',

                        style: TextStyle(

                          fontWeight: FontWeight.bold,

                        ),

                      ),



                      const SizedBox(height: 15),



                      Row(

                        children: [

                          Expanded(

                            child: _StatusBox(

                              title: 'Left Ear',

                              status: leftStatus,

                            ),

                          ),

                          const SizedBox(width: 12),

                          Expanded(

                            child: _StatusBox(

                              title: 'Right Ear',

                              status: rightStatus,

                            ),

                          ),

                        ],

                      ),

                    ],

                  ),

                ),

              ),



              const SizedBox(height: 20),



              const Text(

                'Recorded Measurements',

                style: TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 10),



              if (measurements.isEmpty)

                const Card(

                  child: Padding(

                    padding: EdgeInsets.all(20),

                    child: Text(

                      'No measurements recorded.',

                      textAlign: TextAlign.center,

                    ),

                  ),

                )

              else

                ...measurements.map(

                  (measurement) => Card(

                    child: ListTile(

                      leading: Icon(

                        measurement.heard

                            ? Icons.check_circle

                            : Icons.cancel,

                        color: measurement.heard

                            ? Colors.green

                            : Colors.red,

                      ),

                      title: Text(

                        '${measurement.frequency} Hz • '

                        '${measurement.level} level',

                      ),

                      subtitle: Text(

                        measurement.ear,

                      ),

                      trailing: Text(

                        measurement.heard

                            ? 'Heard'

                            : 'Not Heard',

                        style: TextStyle(

                          fontWeight: FontWeight.bold,

                          color: measurement.heard

                              ? Colors.green

                              : Colors.red,

                        ),

                      ),

                    ),

                  ),

                ),



              const SizedBox(height: 20),



              OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AudiogramScreen(
                      childName: childName,
                      measurements: measurements,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.show_chart),
              label: const Text('View Audiogram'),
            ),

            const SizedBox(height: 12),

            FilledButton.icon(
              onPressed: () async {
                try {
                  await Printing.layoutPdf(
                    onLayout: (format) => _buildScreeningPdf(
                      childName: childName,
                      measurements: measurements,
                      leftStatus: leftStatus,
                      rightStatus: rightStatus,
                    ),
                  );
                } catch (error) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Could not create report: $error')),
                    );
                  }
                }
              },
              icon: const Icon(Icons.download),
              label: const Text('Download Screening Report (PDF)'),
            ),

              const SizedBox(height: 12),



              Container(

                padding: const EdgeInsets.all(15),

                decoration: BoxDecoration(

                  color: Colors.orange.shade50,

                  borderRadius: BorderRadius.circular(12),

                ),

                child: const Text(

                  'Screening result only. This application does not '

                  'provide a medical diagnosis. Clinical interpretation '

                  'requires validated calibration and professional '

                  'assessment.',

                  textAlign: TextAlign.center,

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }

}



// ============================================================

// STATUS BOX

// ============================================================



class _StatusBox extends StatelessWidget {

  final String title;

  final String status;



  const _StatusBox({

    required this.title,

    required this.status,

  });



  @override

  Widget build(BuildContext context) {

    final isPass = status == 'PASS';



    return Container(

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(

        color: isPass

            ? Colors.green.shade50

            : Colors.orange.shade50,

        borderRadius: BorderRadius.circular(12),

        border: Border.all(

          color: isPass

              ? Colors.green.shade200

              : Colors.orange.shade200,

        ),

      ),

      child: Column(

        children: [

          Text(

            title,

            style: const TextStyle(

              fontWeight: FontWeight.bold,

            ),

          ),



          const SizedBox(height: 8),



          Text(

            status,

            style: TextStyle(

              fontSize: 20,

              fontWeight: FontWeight.bold,

              color: isPass

                  ? Colors.green

                  : Colors.orange,

            ),

          ),

        ],

      ),

    );

  }

}

// ============================================================
// AUDIOGRAM VISUALIZATION
// ============================================================

class AudiogramScreen extends StatelessWidget {
  final String childName;
  final List<HearingMeasurement> measurements;

  const AudiogramScreen({
    super.key,
    required this.childName,
    required this.measurements,
  });

  static const List<int> frequencies = [250, 500, 1000, 2000, 4000, 8000];

  @override
  Widget build(BuildContext context) {
    final left = measurements.where((m) => m.ear == 'Left Ear').toList()
      ..sort((a, b) => a.frequency.compareTo(b.frequency));
    final right = measurements.where((m) => m.ear == 'Right Ear').toList()
      ..sort((a, b) => a.frequency.compareTo(b.frequency));

    return Scaffold(
      appBar: AppBar(title: const Text('Audiogram')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('Child: $childName', style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold,
          )),
          const SizedBox(height: 8),
          const Text('Recorded test levels by frequency'),
          const SizedBox(height: 16),
          if (measurements.isEmpty)
            const Card(child: Padding(
              padding: EdgeInsets.all(20),
              child: Text('No measurements available to plot.'),
            ))
          else
            Card(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 16, 16),
                child: SizedBox(
                  height: 320,
                  child: LineChart(LineChartData(
                    minX: 0,
                    maxX: 5,
                    minY: 0,
                    maxY: _maxLevel(),
                    gridData: const FlGridData(show: true),
                    borderData: FlBorderData(show: true),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles(
                        axisNameWidget: const Text('Frequency (Hz)'),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          reservedSize: 36,
                          getTitlesWidget: (value, meta) {
                            final index = value.round();
                            if (index < 0 || index >= frequencies.length) {
                              return const SizedBox.shrink();
                            }
                            final frequency = frequencies[index];
                            final label = frequency >= 1000
                                ? '${frequency ~/ 1000}k'
                                : '$frequency';
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(label,
                                style: const TextStyle(fontSize: 10)),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        axisNameWidget: const Text('Test level (uncalibrated)'),
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 10,
                          reservedSize: 38,
                          getTitlesWidget: (value, meta) =>
                              Text(value.toInt().toString()),
                        ),
                      ),
                    ),
                    lineBarsData: [
                      _makeLine(left, Colors.blue),
                      _makeLine(right, Colors.red),
                    ],
                  )),
                ),
              ),
            ),
          const SizedBox(height: 12),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 18,
            children: [
              _ChartLegend(color: Colors.blue, label: 'Left ear'),
              _ChartLegend(color: Colors.red, label: 'Right ear'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Recorded responses', style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold,
          )),
          if (measurements.isEmpty)
            const ListTile(title: Text('No responses recorded.'))
          else
            ...measurements.map((m) => ListTile(
              dense: true,
              leading: Icon(
                m.heard ? Icons.check_circle : Icons.cancel,
                color: m.heard ? Colors.green : Colors.red,
              ),
              title: Text('${m.frequency} Hz — ${m.level} level'),
              subtitle: Text(m.ear),
              trailing: Text(m.heard ? 'Heard' : 'Not heard'),
            )),
          const SizedBox(height: 12),
          const Text(
            'Screening visualization only. These software test levels are not '
            'calibrated dB HL hearing thresholds. This app does not provide a '
            'medical diagnosis; clinical interpretation requires validated '
            'calibration and assessment by a qualified professional.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.deepOrange),
          ),
        ],
      ),
    );
  }

  double _maxLevel() {
    final highest = measurements.fold<int>(
      0,
      (current, measurement) =>
          measurement.level > current ? measurement.level : current,
    );
    final rounded = ((highest + 9) ~/ 10) * 10;
    return (rounded < 70 ? 70 : rounded).toDouble();
  }

  LineChartBarData _makeLine(List<HearingMeasurement> data, Color color) {
    final spots = data
        .where((m) => frequencies.contains(m.frequency))
        .map((m) => FlSpot(
              frequencies.indexOf(m.frequency).toDouble(),
              m.level.toDouble(),
            ))
        .toList();
    return LineChartBarData(
      spots: spots,
      isCurved: false,
      color: color,
      // Points are the measurements; do not connect frequencies with a line.
      barWidth: 0,
      dotData: FlDotData(show: true),
    );
  }
}

class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;

  const _ChartLegend({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.circle, color: color, size: 12),
      const SizedBox(width: 6),
      Text(label),
    ]);
  }
}


// Creates a printable/shareable PDF report. The platform print dialog allows
// the user to save the report as a PDF where supported.
Future<Uint8List> _buildScreeningPdf({
  required String childName,
  required List<HearingMeasurement> measurements,
  required String leftStatus,
  required String rightStatus,
}) async {
  final document = pw.Document();
  final generatedAt = DateTime.now();
  final dateText =
      '${generatedAt.day.toString().padLeft(2, '0')}/'
      '${generatedAt.month.toString().padLeft(2, '0')}/'
      '${generatedAt.year}';

  document.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      build: (context) => [
        pw.Text(
          'Mobile Audiometer - Screening Report',
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
        ),
        pw.SizedBox(height: 8),
        pw.Text('Generated: $dateText'),
        pw.SizedBox(height: 16),
        pw.Text('Child: $childName',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 12),
        pw.TableHelper.fromTextArray(
          headers: ['Ear', 'Screening status'],
          data: [
            ['Left Ear', leftStatus],
            ['Right Ear', rightStatus],
          ],
          headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          border: pw.TableBorder.all(color: PdfColors.grey400),
          cellPadding: const pw.EdgeInsets.all(7),
        ),
        pw.SizedBox(height: 18),
        pw.Text('Recorded measurements',
            style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        if (measurements.isEmpty)
          pw.Text('No measurements were recorded.')
        else
          pw.TableHelper.fromTextArray(
            headers: ['Ear', 'Frequency (Hz)', 'Test level*', 'Response'],
            data: measurements
                .map((m) => [
                      m.ear,
                      '${m.frequency}',
                      '${m.level}',
                      m.heard ? 'Heard' : 'Not heard',
                    ])
                .toList(),
            headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            border: pw.TableBorder.all(color: PdfColors.grey400),
            cellPadding: const pw.EdgeInsets.all(6),
          ),
        pw.SizedBox(height: 18),
        pw.Text(
          '* Test levels are software levels and are not calibrated dB HL hearing thresholds.',
          style: const pw.TextStyle(fontSize: 10),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          'This report is for preliminary hearing screening and referral support only. '
          'It is not a medical diagnosis. Results must not be used to rule out hearing '
          'loss. Clinical interpretation requires validated device and earphone '
          'calibration and assessment by a qualified hearing-care professional.',
          style: const pw.TextStyle(fontSize: 10),
        ),
      ],
    ),
  );

  return document.save();
}
