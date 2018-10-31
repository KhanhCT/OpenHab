#!/bin/bash
cat > /etc/openhab2/things/xiaomi.things << EOF
Bridge mihome:bridge:7c49eb17d303 "Xiaomi Gateway" [ serialNumber="7c49eb17d303", ipAddress="192.168.0.112", port=9898, key="XXXXXXXXXXXXXXXX", pollingInterval=6000 ]
{
    Thing mihome:gateway:7c49eb17d303 "Xiaomi Mi Smart Home Gateway" [itemId="7c49eb17d303"]

    Thing mihome:ctrl_ln2:158d00024db8f7 "Aqara Wireless Wall Switch" [itemId="158d00024db8f7"]
}
EOF

cat > /etc/openhab2/items/xiaomi.items << EOF
// Gateway
Switch Gateway_AddDevice { channel="mihome:gateway:c49eb17d303:joinPermission" }
Switch Gateway_LightSwitch <light> { channel="mihome:gateway:c49eb17d303:brightness" }
Color Gateway_Color <rgb> { channel="mihome:gateway:c49eb17d303:color" }
Dimmer Gateway_ColorTemperature <heating> { channel="mihome:gateway:c49eb17d303:colorTemperature" }
Number Gateway_AmbientLight <sun> { channel="mihome:gateway:c49eb17d303:illumination" }
Number Gateway_Sound <soundvolume-0> { channel="mihome:gateway:c49eb17d303:sound" }
Switch Gateway_SoundSwitch <soundvolume_mute> { channel="mihome:gateway:c49eb17d303:enableSound" }
Dimmer Gateway_SoundVolume <soundvolume> { channel="mihome:gateway:c49eb17d303:volume" }
EOF
cat > /etc/openhab2/rules/xiaomi.rules << EOF
rule "Play quiet knock-knock ringtone with the Xiaomi Gateway"
when
    // Item ExampleSwitch changed to ON
then
    sendCommand(Gateway_SoundVolume, 2)
    sendCommand(Gateway_Sound, 11)
    Thread::sleep(2000) /* wait for 2 seconds */
    sendCommand(Gateway_Sound, 10000)
    sendCommand(Gateway_SoundVolume, 0)
end
EOF
cat > /etc/openhab2/sitemaps/xiaomi.sitemap << EOF
sitemap xiaomi label="Xiaomi" {
    // Example for selection of predefined sound file - you can also upload your own files with the official MiHome App and play them!
	Frame {
        ...

        // Selection for Xiaomi Gateway Sounds
        // 10000 is STOP
        // >10001 are own sounds you uploaded to the gateway
        Selection item=Gateway_Sound mappings=[ 0="police car 1",
                                                1="police car 2",
                                                2="accident",
                                                3="countdown",
                                                4="ghost",
                                                5="sniper rifle",
                                                6="battle",
                                                7="air raid",
                                                8="bark",
                                                10="doorbell",
                                                11="knock at a door",
                                                12="amuse",
                                                13="alarm clock",
                                                20="mimix",
                                                21="enthusuastic",
                                                22="guitar classic",
                                                23="ice world piano",
                                                24="leisure time",
                                                25="child hood",
                                                26="morning stream liet",
                                                27="music box",
                                                28="orange",
                                                29="thinker"]
    }
}
EOF