import 'package:flutter/material.dart';


class Suggestions extends StatelessWidget {
  const Suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Get.off(PatientDashboard()),
        // ),
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Health Suggestions"),
      ),
      body: ListView(
        children: [
          Card(
              elevation: 5,
              child: SizedBox(
                child: ListTile(
                  leading: Image.network(
                      "https://th.bing.com/th/id/R.a58df9b471002496c9956a105c3fecab?rik=VhTSdTRicn29Ow&riu=http%3a%2f%2freachingutopia.com%2fwp-content%2fuploads%2f2013%2f05%2fman-headache.jpg&ehk=l8cnfpmzKPSwNSqIzZO1t%2f7Z%2fDHpuI6wdY6NHDgu8oU%3d&risl=&pid=ImgRaw&r=0"),
                  title: Text("Headache"),
                  subtitle: Text("panadol, brufin, Calpol"),
                ),
              )),
          Card(
              elevation: 5,
              child: SizedBox(
                child: ListTile(
                  leading: Image.network(
                      "https://www.seattlechildrens.org/globalassets/images/health-and-safety/social/about-the-flu---facebook.jpg"),
                  title: Text("Flu"),
                  subtitle: Text("panadol, brufin, Calpol"),
                ),
              )),
          Card(
              elevation: 5,
              child: SizedBox(
                child: ListTile(
                  leading: Image.network(
                      "https://th.bing.com/th/id/OIP.69LAgmb-1rHVfGCWbDVfCgHaFE?w=235&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
                  title: Text("Caught"),
                  subtitle: Text("Hyrin, brufin, Calpol"),
                ),
              )),
          Card(
              elevation: 5,
              child: SizedBox(
                child: ListTile(
                  leading: Image.network(
                      "https://th.bing.com/th/id/R.7f4b41db445c04acdbdc07d64f4da199?rik=vnbGHkUVFugs8g&pid=ImgRaw&r=0"),
                  title: Text("Fever"),
                  subtitle: Text("panadol, brufin, Calpol"),
                ),
              )),
          Card(
              elevation: 5,
              child: SizedBox(
                child: ListTile(
                  leading: Image.network(
                      "https://thumbs.dreamstime.com/b/senior-man-vomiting-vector-illustration-original-paintings-drawing-71856549.jpg"),
                  title: Text("Vomit"),
                  subtitle: Text("panadol, brufin, Calpol"),
                ),
              )),
          Card(
              elevation: 5,
              child: SizedBox(
                child: ListTile(
                  leading: Image.network(
                      "https://th.bing.com/th/id/OIP.2WVTyE6UXNUQblXXfPSkeQHaFj?pid=ImgDet&rs=1"),
                  title: Text("Drizziness"),
                  subtitle: Text("panadol, brufin, Calpol"),
                ),
              ))
        ],
      ),
    );
  }
}
