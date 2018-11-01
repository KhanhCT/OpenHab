cat > /etc/openhab2/things/xiaomi.things << EOF
Bridge mihome:bridge:7c49eb17d303 "Xiaomi Gateway" [ serialNumber="7c49eb17d303", ipAddress="192.168.0.112", port=9898, key="4ED0259DBFB34424", pollingInterval=6000 ]
{
    Thing mihome:gateway:7c49eb17d303 "Xiaomi Mi Smart Home Gateway" [itemId="7c49eb17d303"]
    Thing mihome:ctrl_ln2:158d00024db8f7 "Aqara Wireless Wall Switch" [itemId="158d00024db8f7"]
}
EOF
cat > /etc/openhab2/items/xiaomi.items << EOF
// Gateway
Switch Gateway_AddDevice { channel="mihome:gateway:7c49eb17d303:joinPermission" }
Switch Gateway_LightSwitch <light> { channel="mihome:gateway:7c49eb17d303:brightness" }
Color Gateway_Color <rgb> { channel="mihome:gateway:7c49eb17d303:color" }
Dimmer Gateway_ColorTemperature <heating> { channel="mihome:gateway:7c49eb17d303:colorTemperature" }
Number Gateway_AmbientLight <sun> { channel="mihome:gateway:7c49eb17d303:illumination" }
Number Gateway_Sound <soundvolume-0> { channel="mihome:gateway:7c49eb17d303:sound" }
Switch Gateway_SoundSwitch <soundvolume_mute> { channel="mihome:gateway:7c49eb17d303:enableSound" }
Dimmer Gateway_SoundVolume <soundvolume> { channel="mihome:gateway:7c49eb17d303:volume" }
Switch SW1 <light> { channel="mihome:ctrl_ln2:158d00024db8f7:ch1" }
Switch SW2 <light> { channel="mihome:ctrl_ln2:158d00024db8f7:ch2" }
EOF
cat > /etc/openhab2/rules/xiaomi.rules << EOF
rule "SW1_ON"
when   
    Item SW1 changed from OFF to ON
then   
    sendCommand(SW1, ON)
end
rule "SW1_OFF"
when   
    Item SW1 changed from ON to OFF
then   
    sendCommand(SW1, OFF)
end
EOF
cat > /etc/openhab2/sitemaps/xiaomi.sitemap << EOF
sitemap xiaomi label="Xiaomi" {
	Frame {
        Switch item=SW1_OFF icon="light"
    }
}
EOF
