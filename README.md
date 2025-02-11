**SmartTarget**

FFXI Windower Addon

**DISCLAIMER:**

This addon is a third-party tool designed for use with Final Fantasy XI. Use it at your own risk. The creator of this addon is not affiliated with Square Enix and is not responsible for any consequences arising from its use, including but not limited to violations of the game’s terms of service, account penalties, or unintended game behavior. By using this addon, you acknowledge and accept any potential risks involved.

**DESCRIPTION:**

The SmartTarget addon is a tool to quickly target monsters by name(or partial name), by direct id, or by the hex index/id.

**KNOWN ISSUES:**

Some targets are immune to targetting via SmartTarget for unknown reasons.

Some known examples include the Einherjar Lamp NPC and Oboro in Port Jeuno.


**INSTRUCTIONS:**

In the windower console;

lua l SmartTarget -- Loads the addon

lua u SmartTarget -- Unloads the addon

SmartTarget name -- by entering text, it will targets by name or partial name

SmartTarget 012345 -- just using a number, it will target by internal mob ID

SmartTarget id 0FF -- by entering id and a hex identifier, it will target by the hex index (usually what is posted on bgwiki pages to identify placeholders)

You can also use t, ta, or target in place of SmartTarget. Some Examples:

//t home point

//ta Aurix

//target id 4D
