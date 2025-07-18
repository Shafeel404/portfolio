import 'package:portfolio/pages/myself/common/common_app_bar.dart';
import 'package:portfolio/pages/myself/common/common_footer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/addl/HeaderLink.dart';
import 'package:portfolio/pages/myself/common/common_app_bar.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

class Myself extends StatelessWidget {
  const Myself({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalPadding =
        ResponsiveValue<double>(
          context,
          defaultValue: 8.0,
          conditionalValues: const [
            Condition.largerThan(name: TABLET, value: 100.0),
            Condition.largerThan(name: MOBILE, value: 20.0),
          ],
        ).value;

    return Scaffold(
      backgroundColor: Color(0xFF232425),
      appBar: CommonAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Shafeel T',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '"Building robust backends with Spring Boot and beautiful frontends with Flutter."',
                      style: TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final Uri emailUri = Uri(
                              scheme: 'mailto',
                              path: 'shafeelt404@gmail.com',
                              query: 'subject=Hello&body=Hi there!',
                            );
                            if (await canLaunchUrl(emailUri)) {
                              await launchUrl(emailUri);
                            } else {
                              print('Could not launch email client');
                            }
                          },
                          icon: Icon(Icons.mail),
                        ),
                        IconButton(
                          onPressed: () async {
                            const url = 'https://www.github.com/shafeel404';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(
                                Uri.parse(url),
                                webOnlyWindowName: '_blank',
                              );
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.github),
                        ),
                        IconButton(
                          onPressed: () async {
                            const url =
                                'https://www.linkedin.com/in/shafeel-t-9804ab223';
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(
                                Uri.parse(url),
                                webOnlyWindowName: '_blank',
                              );
                            }
                          },
                          icon: FaIcon(FontAwesomeIcons.linkedin),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(FontAwesomeIcons.twitter),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          CommonFooter(width: 20.0),
        ],
      ),
    );
  }
}
