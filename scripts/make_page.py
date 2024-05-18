import os
import sys

# make directories for a new page for the app

# root
ui = 'lib/core'

# Create predefined files
folders = ['widgets', 'views']

widgets = folders[0]
views = folders[1]


def create_new_page(name, path=None):
    if path is None:
        path = os.getcwd()  # Use current working directory if path is not provided

    project_dir = os.path.join(path, ui, name)
    print('Creating dir at ' + project_dir)
    os.makedirs(project_dir, exist_ok=True)

    # Create predefined folders
    for folder in folders:
        folder_path = os.path.join(project_dir, folder)
        os.makedirs(folder_path, exist_ok=True)

    view, mobile, desktop, controller = create_file_contents(name)

    files = [
        (f'{name}.providers.dart', ''),
        (f'{name}.utils.dart', ''),
        (f'{name}.controller.dart', controller),
        (f'{views}/{name}.view.dart', view),
        (f'{views}/{name}.view.desktop.dart', desktop),
        (f'{views}/{name}.view.mobile.dart', mobile),
    ]

    for file_name, file_content in files:
        file_path = os.path.join(project_dir, file_name)
        with open(file_path, 'w') as file:
            file.write(file_content)

    print(f"Page '{name}' created at: {project_dir}")
    print('Dont forget to add the page to the router')


def create_file_contents(page_name):
    page_name = page_name.capitalize()
    view = f'''import 'package:flutter/material.dart';

import 'package:jellybean/navigation/nav_utils.dart';
import 'package:jellybean/core/{page_name.lower()}/{views}/{page_name.lower()}.view.desktop.dart';
import 'package:jellybean/core/{page_name.lower()}/{views}/{page_name.lower()}.view.mobile.dart';

class {page_name}View extends StatelessWidget {{
  const {page_name}View({{super.key}});

  @override
  Widget build(BuildContext context) {{
    // TODO UI
    return const LayoutSwitcher(
      mobileLayout: {page_name}MobileView(),
      desktopLayout: {page_name}DesktopView(),
    );
  }}
}}'''

    mobileview = f'''import 'package:flutter/widgets.dart';

class {page_name}MobileView extends StatelessWidget {{
  const {page_name}MobileView({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return const Placeholder();
  }}
}}'''

    desktopview = f'''import 'package:flutter/widgets.dart';

class {page_name}DesktopView extends StatelessWidget {{
  const {page_name}DesktopView({{super.key}});

  @override
  Widget build(BuildContext context) {{
    return const Placeholder();
  }}
}}'''

    controller = f'''
class {page_name}Controller {{
  const {page_name}Controller();
}}'''

    return view, mobileview, desktopview, controller


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Please provide a page name.")
        sys.exit(1)

    project_name = sys.argv[1]
    project_path = sys.argv[2] if len(sys.argv) > 2 else None

    create_new_page(project_name, project_path)
