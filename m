Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E86339E165
	for <gfs2@lists.linux.dev>; Tue,  3 Feb 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770125706; cv=none; b=nb7pWWxP94Ta7Fg5tF2N487asXZg/qdfL41YKWSUwClQW0d5Bf69ZTVOrSvk9JENTmCebWQT5nKCesKBvk10LngudH6YuY/F4fz3nTfe05aYSyKsdwgRDQ9d0TQnfXI8ZMc0P9M/n3iPcj5lPxUT1rDezCAR+m1J6zqdR3b7gXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770125706; c=relaxed/simple;
	bh=8cAYho0mhGU+srCNhbVbPB7x376PMmIWJUsni4Tl1UI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vm360nbKrPZhnIxrPQoL+XMlpX5DEz5t148xJ5+jtIH7X9jDRAOcMMUm292LmffeDgmuKS0z2283ZRqRWesy6NL26Yz0UbtpcxwgCwt1Zf04wioEK5qymv44FkTkPOIxsSlw0rDEGx+Mwk/7F1oxPKcK36nt4VWjjdnqK8AO8CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-6631840318fso15632805eaf.2
        for <gfs2@lists.linux.dev>; Tue, 03 Feb 2026 05:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770125703; x=1770730503;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGGhMNRqWvxnFG6tSwRFZ819l6JctF1zTrDSzU9Q65Y=;
        b=AHO+John75iDO9Zz5FGxEEZXJXGblAL/x4C9DFvRkR3lOuDBVsF/fg1gDqYBPSv1OX
         QcNFlUO0/lHCLRfQUQ4kir1YqpNB/tXihOPxUHzWFXjjlROjBmJvVnty9OoexLZw+Grn
         /qmRM/vhdCRFFhCqYogAvkWX5BM9zEnovQqGuwbJxP1vsS7rHGQSeS1qGcReLsMTItP+
         mfg1IALjnu8PTE0hoZVpTOlG+77O/88x1TBHnYdrEfZACgKJkOj46CkvhhTEbEGYmeNC
         5npbjS4cL2X0P4SIbpc2oz9ccO45yFLreMgCj2/P2FgHWqBqEdXvkmKQJhWA1SNqlWb/
         557w==
X-Forwarded-Encrypted: i=1; AJvYcCUI2cWI+/Qo3XTMu0VnI4h96Ra173rotG79QNbrWJrXAaDHQoCiWAq/aFWy1AMbtk1Mw7kt@lists.linux.dev
X-Gm-Message-State: AOJu0YxQFRmou+mpa/FgZlHZM2YvxlmYvR0CN0J1ZZtG8xOvZ8DL2Rcc
	nu8iOO8Dgk7HexkYyO86AK6Ego7YOfiglFfnLhonpDh1R3BMYs3cRtWGPB6fTzG5MElxDyikvpU
	v0vjSpn5apZvAuphgBHVVnoJmddOvj3PlLe1BEW2U5kVgzE8foqzEkyNlCBc=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2987:b0:663:f65:1c8b with SMTP id
 006d021491bc7-6630f651d1bmr4974824eaf.51.1770125703233; Tue, 03 Feb 2026
 05:35:03 -0800 (PST)
Date: Tue, 03 Feb 2026 05:35:03 -0800
In-Reply-To: <CAHc6FU6rnwZoq4_OqT9wo-G0anrtLkOcdO=WdP6JAJf6Yhx90A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6981f987.050a0220.3b3015.000c.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] memory leak in __kthread_create_on_node
From: syzbot <syzbot+aac438d7a1c44071e04b@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

: port 1(bridge_slave_0) entered blocking state
[   49.569526][ T5894] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   49.577272][ T5894] bridge_slave_0: entered allmulticast mode
[   49.583706][ T5894] bridge_slave_0: entered promiscuous mode
[   49.596953][ T5894] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   49.604391][ T5894] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   49.611600][ T5894] bridge_slave_1: entered allmulticast mode
[   49.618015][ T5894] bridge_slave_1: entered promiscuous mode
[   49.628063][ T5894] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   49.638158][ T5894] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   49.651127][ T5894] team0: Port device team_slave_0 added
[   49.657258][ T5894] team0: Port device team_slave_1 added
[   49.666478][ T5894] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   49.673408][ T5894] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   49.699306][ T5894] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   49.710247][ T5894] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   49.717331][ T5894] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   49.743223][ T5894] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   49.761247][ T5894] hsr_slave_0: entered promiscuous mode
[   49.767053][ T5894] hsr_slave_1: entered promiscuous mode
[   49.796552][ T5894] netdevsim netdevsim5 netdevsim0: renamed from eth0
[   49.806103][ T5894] netdevsim netdevsim5 netdevsim1: renamed from eth1
[   49.813706][ T5894] netdevsim netdevsim5 netdevsim2: renamed from eth2
[   49.821484][ T5894] netdevsim netdevsim5 netdevsim3: renamed from eth3
[   49.833675][ T5894] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   49.840885][ T5894] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   49.848233][ T5894] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   49.855361][ T5894] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   49.874093][ T5894] 8021q: adding VLAN 0 to HW filter on device bond0
[   49.883306][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   49.890757][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   49.899998][ T5894] 8021q: adding VLAN 0 to HW filter on device team0
[   49.908475][ T4273] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   49.915629][ T4273] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   49.926439][   T31] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   49.933487][   T31] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   49.976870][ T5894] 8021q: adding VLAN 0 to HW filter on device batadv0
[   50.019341][ T5894] veth0_vlan: entered promiscuous mode
[   50.027485][ T5894] veth1_vlan: entered promiscuous mode
[   50.037907][ T5894] veth0_macvtap: entered promiscuous mode
[   50.045065][ T5894] veth1_macvtap: entered promiscuous mode
[   50.053367][ T5894] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   50.062517][ T5894] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
2026/02/03 13:34:00 executed programs: 0
[   50.071587][   T31] netdevsim netdevsim5 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.080766][   T31] netdevsim netdevsim5 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.089873][   T31] netdevsim netdevsim5 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.098962][   T31] netdevsim netdevsim5 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.146631][   T51] Bluetooth: hci0: unexpected cc 0x0c03 length: 249 > =
1
[   50.153698][   T51] Bluetooth: hci0: unexpected cc 0x1003 length: 249 > =
9
[   50.161549][   T51] Bluetooth: hci0: unexpected cc 0x1001 length: 249 > =
9
[   50.169537][   T51] Bluetooth: hci0: unexpected cc 0x0c23 length: 249 > =
4
[   50.176954][   T51] Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > =
2
[   50.211055][ T5935] chnl_net:caif_netlink_parms(): no params data found
[   50.232507][ T5935] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.239849][ T5935] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   50.247221][ T5935] bridge_slave_0: entered allmulticast mode
[   50.253454][ T5935] bridge_slave_0: entered promiscuous mode
[   50.260028][ T5935] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.267129][ T5935] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   50.274406][ T5935] bridge_slave_1: entered allmulticast mode
[   50.280561][ T5935] bridge_slave_1: entered promiscuous mode
[   50.291387][ T5935] bond0: (slave bond_slave_0): Enslaving as an active =
interface with an up link
[   50.301433][ T5935] bond0: (slave bond_slave_1): Enslaving as an active =
interface with an up link
[   50.315273][ T5935] team0: Port device team_slave_0 added
[   50.321623][ T5935] team0: Port device team_slave_1 added
[   50.331276][ T5935] batman_adv: batadv0: Adding interface: batadv_slave_=
0
[   50.338331][ T5935] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_0 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   50.364309][ T5935] batman_adv: batadv0: Not using interface batadv_slav=
e_0 (retrying later): interface not active
[   50.375554][ T5935] batman_adv: batadv0: Adding interface: batadv_slave_=
1
[   50.382485][ T5935] batman_adv: batadv0: The MTU of interface batadv_sla=
ve_1 is too small (1500) to handle the transport of batman-adv packets. Pac=
kets going over this interface will be fragmented on layer2 which could imp=
act the performance. Setting the MTU to 1532 would solve the problem.
[   50.408696][ T5935] batman_adv: batadv0: Not using interface batadv_slav=
e_1 (retrying later): interface not active
[   50.426057][ T5935] hsr_slave_0: entered promiscuous mode
[   50.431913][ T5935] hsr_slave_1: entered promiscuous mode
[   50.437731][ T5935] debugfs: 'hsr0' already exists in 'hsr'
[   50.443458][ T5935] Cannot create hsr debugfs directory
[   50.471333][ T5935] netdevsim netdevsim0 netdevsim0: renamed from eth0
[   50.479234][ T5935] netdevsim netdevsim0 netdevsim1: renamed from eth1
[   50.486892][ T5935] netdevsim netdevsim0 netdevsim2: renamed from eth2
[   50.494636][ T5935] netdevsim netdevsim0 netdevsim3: renamed from eth3
[   50.506883][ T5935] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.513937][ T5935] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   50.521151][ T5935] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.528314][ T5935] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   50.546104][ T5935] 8021q: adding VLAN 0 to HW filter on device bond0
[   50.555923][ T1028] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   50.563234][ T1028] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   50.572397][ T5935] 8021q: adding VLAN 0 to HW filter on device team0
[   50.580932][ T4273] bridge0: port 1(bridge_slave_0) entered blocking sta=
te
[   50.587999][ T4273] bridge0: port 1(bridge_slave_0) entered forwarding s=
tate
[   50.597473][ T1028] bridge0: port 2(bridge_slave_1) entered blocking sta=
te
[   50.604528][ T1028] bridge0: port 2(bridge_slave_1) entered forwarding s=
tate
[   50.647463][ T5935] 8021q: adding VLAN 0 to HW filter on device batadv0
[   50.662929][ T5935] veth0_vlan: entered promiscuous mode
[   50.670959][ T5935] veth1_vlan: entered promiscuous mode
[   50.681606][ T5935] veth0_macvtap: entered promiscuous mode
[   50.688740][ T5935] veth1_macvtap: entered promiscuous mode
[   50.697748][ T5935] batman_adv: batadv0: Interface activated: batadv_sla=
ve_0
[   50.707515][ T5935] batman_adv: batadv0: Interface activated: batadv_sla=
ve_1
[   50.716544][ T4273] netdevsim netdevsim0 netdevsim0: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.725515][ T4273] netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.734628][ T4273] netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.744542][ T4273] netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 f=
amily 0 port 6081 - 0
[   50.762892][ T4273] wlan0: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   50.771050][ T4273] wlan0: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   50.781621][   T31] wlan1: Created IBSS using preconfigured BSSID 50:50:=
50:50:50:50
[   50.789850][   T31] wlan1: Creating new IBSS network, BSSID 50:50:50:50:=
50:50
[   50.879037][   T31] netdevsim netdevsim5 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   50.915713][   T31] netdevsim netdevsim5 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   51.004863][   T31] netdevsim netdevsim5 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   51.074863][   T31] netdevsim netdevsim5 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   52.016178][   T31] bridge_slave_1: left allmulticast mode
[   52.021837][   T31] bridge_slave_1: left promiscuous mode
[   52.027571][   T31] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   52.035331][   T31] bridge_slave_0: left allmulticast mode
[   52.040954][   T31] bridge_slave_0: left promiscuous mode
[   52.046653][   T31] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   52.106207][   T31] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   52.115467][   T31] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   52.125163][   T31] bond0 (unregistering): Released all slaves
[   52.193847][   T31] hsr_slave_0: left promiscuous mode
[   52.200333][   T31] hsr_slave_1: left promiscuous mode
[   52.206079][   T31] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   52.213540][   T31] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   52.221223][   T31] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   52.228932][   T31] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   52.237267][   T31] veth1_macvtap: left promiscuous mode
[   52.242816][   T31] veth0_macvtap: left promiscuous mode
[   52.248610][   T31] veth1_vlan: left promiscuous mode
[   52.253921][   T31] veth0_vlan: left promiscuous mode
[   52.277608][   T31] team0 (unregistering): Port device team_slave_1 remo=
ved
[   52.286132][   T31] team0 (unregistering): Port device team_slave_0 remo=
ved
[   52.766136][ T1028] netdevsim netdevsim0 netdevsim3 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   54.465080][ T1028] netdevsim netdevsim0 netdevsim2 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   54.525147][ T1028] netdevsim netdevsim0 netdevsim1 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   54.565331][ T1028] netdevsim netdevsim0 netdevsim0 (unregistering): uns=
et [1, 0] type 2 family 0 port 6081 - 0
[   54.639649][ T1028] bridge_slave_1: left allmulticast mode
[   54.645358][ T1028] bridge_slave_1: left promiscuous mode
[   54.651032][ T1028] bridge0: port 2(bridge_slave_1) entered disabled sta=
te
[   54.658760][ T1028] bridge_slave_0: left allmulticast mode
[   54.664566][ T1028] bridge_slave_0: left promiscuous mode
[   54.670254][ T1028] bridge0: port 1(bridge_slave_0) entered disabled sta=
te
[   54.726139][ T1028] bond0 (unregistering): (slave bond_slave_0): Releasi=
ng backup interface
[   54.735307][ T1028] bond0 (unregistering): (slave bond_slave_1): Releasi=
ng backup interface
[   54.744759][ T1028] bond0 (unregistering): Released all slaves
[   54.858073][ T1028] hsr_slave_0: left promiscuous mode
[   54.865227][ T1028] hsr_slave_1: left promiscuous mode
[   54.870765][ T1028] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_0
[   54.878359][ T1028] batman_adv: batadv0: Removing interface: batadv_slav=
e_0
[   54.886112][ T1028] batman_adv: batadv0: Interface deactivated: batadv_s=
lave_1
[   54.893489][ T1028] batman_adv: batadv0: Removing interface: batadv_slav=
e_1
[   54.903185][ T1028] veth1_macvtap: left promiscuous mode
[   54.908932][ T1028] veth0_macvtap: left promiscuous mode
[   54.914513][ T1028] veth1_vlan: left promiscuous mode
[   54.919924][ T1028] veth0_vlan: left promiscuous mode
[   54.943530][ T1028] team0 (unregistering): Port device team_slave_1 remo=
ved
[   54.952050][ T1028] team0 (unregistering): Port device team_slave_0 remo=
ved


syzkaller build log:
go env (err=3D<nil>)
AR=3D'ar'
CC=3D'gcc'
CGO_CFLAGS=3D'-O2 -g'
CGO_CPPFLAGS=3D''
CGO_CXXFLAGS=3D'-O2 -g'
CGO_ENABLED=3D'1'
CGO_FFLAGS=3D'-O2 -g'
CGO_LDFLAGS=3D'-O2 -g'
CXX=3D'g++'
GCCGO=3D'gccgo'
GO111MODULE=3D'auto'
GOAMD64=3D'v1'
GOARCH=3D'amd64'
GOAUTH=3D'netrc'
GOBIN=3D''
GOCACHE=3D'/syzkaller/.cache/go-build'
GOCACHEPROG=3D''
GODEBUG=3D''
GOENV=3D'/syzkaller/.config/go/env'
GOEXE=3D''
GOEXPERIMENT=3D''
GOFIPS140=3D'off'
GOFLAGS=3D''
GOGCCFLAGS=3D'-fPIC -m64 -pthread -Wl,--no-gc-sections -fmessage-length=3D0=
 -ffile-prefix-map=3D/tmp/go-build3933183977=3D/tmp/go-build -gno-record-gc=
c-switches'
GOHOSTARCH=3D'amd64'
GOHOSTOS=3D'linux'
GOINSECURE=3D''
GOMOD=3D'/syzkaller/jobs-2/linux/gopath/src/github.com/google/syzkaller/go.=
mod'
GOMODCACHE=3D'/syzkaller/jobs-2/linux/gopath/pkg/mod'
GONOPROXY=3D''
GONOSUMDB=3D''
GOOS=3D'linux'
GOPATH=3D'/syzkaller/jobs-2/linux/gopath'
GOPRIVATE=3D''
GOPROXY=3D'https://proxy.golang.org,direct'
GOROOT=3D'/usr/local/go'
GOSUMDB=3D'sum.golang.org'
GOTELEMETRY=3D'local'
GOTELEMETRYDIR=3D'/syzkaller/.config/go/telemetry'
GOTMPDIR=3D''
GOTOOLCHAIN=3D'auto'
GOTOOLDIR=3D'/usr/local/go/pkg/tool/linux_amd64'
GOVCS=3D''
GOVERSION=3D'go1.24.4'
GOWORK=3D''
PKG_CONFIG=3D'pkg-config'

git status (err=3D<nil>)
HEAD detached at b78a734197
nothing to commit, working tree clean


tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
go list -f '{{.Stale}}' -ldflags=3D"-s -w -X github.com/google/syzkaller/pr=
og.GitRevision=3Db78a7341979245ec72840af68695cb23b98dc2cb -X github.com/goo=
gle/syzkaller/prog.gitRevisionDate=3D20260128-224926"  ./sys/syz-sysgen | g=
rep -q false || go install -ldflags=3D"-s -w -X github.com/google/syzkaller=
/prog.GitRevision=3Db78a7341979245ec72840af68695cb23b98dc2cb -X github.com/=
google/syzkaller/prog.gitRevisionDate=3D20260128-224926"  ./sys/syz-sysgen
make .descriptions
tput: No value for $TERM and no -T specified
tput: No value for $TERM and no -T specified
Makefile:31: run command via tools/syz-env for best compatibility, see:
Makefile:32: https://github.com/google/syzkaller/blob/master/docs/contribut=
ing.md#using-syz-env
bin/syz-sysgen
touch .descriptions
GOOS=3Dlinux GOARCH=3Damd64 go build -ldflags=3D"-s -w -X github.com/google=
/syzkaller/prog.GitRevision=3Db78a7341979245ec72840af68695cb23b98dc2cb -X g=
ithub.com/google/syzkaller/prog.gitRevisionDate=3D20260128-224926"  -o ./bi=
n/linux_amd64/syz-execprog github.com/google/syzkaller/tools/syz-execprog
mkdir -p ./bin/linux_amd64
g++ -o ./bin/linux_amd64/syz-executor executor/executor.cc \
	-m64 -O2 -pthread -Wall -Werror -Wparentheses -Wunused-const-variable -Wfr=
ame-larger-than=3D16384 -Wno-stringop-overflow -Wno-array-bounds -Wno-forma=
t-overflow -Wno-unused-but-set-variable -Wno-unused-command-line-argument -=
static-pie -std=3Dc++17 -I. -Iexecutor/_include   -DGOOS_linux=3D1 -DGOARCH=
_amd64=3D1 \
	-DHOSTGOOS_linux=3D1 -DGIT_REVISION=3D\"b78a7341979245ec72840af68695cb23b9=
8dc2cb\"
/usr/bin/ld: /tmp/ccJgQDSd.o: in function `Connection::Connect(char const*,=
 char const*)':
executor.cc:(.text._ZN10Connection7ConnectEPKcS1_[_ZN10Connection7ConnectEP=
KcS1_]+0x386): warning: Using 'gethostbyname' in statically linked applicat=
ions requires at runtime the shared libraries from the glibc version used f=
or linking
./tools/check-syzos.sh 2>/dev/null


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=3D10e0c402580000


Tested on:

commit:         da6f5bbc gfs2: fix memory leaks in gfs2_fill_super err..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gf=
s2.git for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=3D9d7d0fbecb37bff=
8
dashboard link: https://syzkaller.appspot.com/bug?extid=3Daac438d7a1c44071e=
04b
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Deb=
ian) 2.44

Note: no patches were applied.
