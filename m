Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8523246E8
	for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246444; cv=none; b=LwgbRiUZoA5peNLVklBHZP0EfYI66p1SsofVChO8c/NzEEukEiTkjb0MI8rOMPDrLf9+ynCGJBIHX89SigdyvMaTqF4VRG50SvU+AWqZcbxo/6CAW5rB8O+qv/3pCYas+3YEyxg/ttUKWbdjTmO63aJRmsXjx+NnsELvJqBI7Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246444; c=relaxed/simple;
	bh=fcPxMUJABRwcqPpCgU0DGzxtmBrg7D0A5rMQCd6hxpc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UdksUTeXHzoKozC3QO/AKhEL6Y9WMMJUDHnAmR9RvT93ZoLwKu8FAO4Zo07o8QpC4hF7FC2k2MsUVAVvjgdOyI3D2MYRGw8WlrJAJ8J1/pRX7fNuXwx95vpEir0ZWxZLVdxpAUa2Sifz9Wq94WLUTKVS8//L2xEh2Lv3R26/UlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7c72ccd60f5so11374417a34.0
        for <gfs2@lists.linux.dev>; Mon, 12 Jan 2026 11:34:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768246442; x=1768851242;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AcurW2kkOzcw7gSjA488A4kfwNdpw882rLyc2UJczNI=;
        b=mQS+ILuFg0/sZRNgS8QnWce2lhqdC47S52Wcx48LrH4bWzZ++T0gfEw7l0/cCe/PpI
         bY5lqV753TGwmPqk8Tt24bniUoHzFOdn6zU1Z+ttVMVGfQqlnM/uywOxZyR6ouHjaFQd
         ohVt+GlvxOzux8p7IOj6Wi3Mjm/nylbX5yEKqLJNBw2gwFkVNhoYLuCON2mKM262ku/c
         PEC4V6aIVc/Rs/kZ1+rVMabe4j8EzaAtP06p7d16OMOlgnnb7ptq0Dxks0tefqcCaHdj
         PHo5/Ht3hFMFFHjI/57V7MeGBA/s0HN/7F7hwUifmFF8Myo3y3x2pEHWZhI1jHjHZ/BM
         ADJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWURklIxrhV698XwJ+6WiKnXWvEtNygi50umQRPH1nAxk75bLY8xGaLjVK9l4FXPJAAA/L7@lists.linux.dev
X-Gm-Message-State: AOJu0Yzxwm4DVcCDUtF0a5BcbfKv5HuJvjeR5HEzIMLRJIxcxS9qh/aB
	gZKVwHnJAxyFvN4YXqyXl4rNhmir8Xot/soLkaRV3DnwTA2Fwjl1qNoCQeDJTfb0Iesaloj3Eq4
	gymreztmix4jFfh+DsFpxE66RtvshO0Bhn9WBqsPMQXztJ8wfPBWmBHuMLSE=
X-Google-Smtp-Source: AGHT+IFvWU5F6wgHC55ULi/dCXn6MPkxirnMgyGTazkS/7hQfBdL1QK6iAEw9yaz8eeX0nWn8xxRxri3m4JlBU3HbOVvMH8relkF
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a4a:b3c3:0:b0:65d:1697:e6ce with SMTP id
 006d021491bc7-65f54eda8d0mr6651398eaf.23.1768246442239; Mon, 12 Jan 2026
 11:34:02 -0800 (PST)
Date: Mon, 12 Jan 2026 11:34:02 -0800
In-Reply-To: <bfe98f76-2c8a-4bb9-a37a-f9b184a9621f@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69654caa.050a0220.38aacd.0000.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING in rgblk_free (2)
From: syzbot <syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com>
To: anprice@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com
Tested-by: syzbot+3e2c95229d1ab81a0bfd@syzkaller.appspotmail.com

Tested on:

commit:         0f61b186 Linux 6.19-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1030a99a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3027d9a5f96d82ca
dashboard link: https://syzkaller.appspot.com/bug?extid=3e2c95229d1ab81a0bfd
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a3e5fa580000

Note: testing is done by a robot and is best-effort only.
