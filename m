Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795754012;
	b=Qk7a/86mRXHMBw4J25JlDGZq5c4wIM8Khy4EnF8mnwKellPURKVppuI39gMi7rNq3sJP
	 iApvqgC9aWv72LtzYjvntMrJmRgM2JVQONgrSF8tqbKjPiJeeMAfSXDb3epHz72WPdctg
	 nmqbIsV0f96+KoNbRJqBNLKgwb6D7jYxqw70LE0i+YYyhyh7B900DN4Z65m8R32o74IeD
	 bSWMVXK5AgM9CkHN7C4hvMATahs7cTZhXDpLv0uKKFOeDP0WfVG1IOoG1+eSu7v77eJew
	 FB3OOgVqL2uHwnMNWRgZIV/ranLn/AjZvrvFyQNzEakqHjj2urAC1d4LOg4TSIIEziw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795754012;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=7rOhMtv2u2ZTS7Y7SzBLnz/8dNSyiaSieAM2fOven2w=;
	b=pZIRNkXM/Q68mlaQega2wb4ZSBDy+ILi8ucuHdAByUAV3ioH6j8im9GGZW7aDWUUd5Rm
	 Mp+c/dFPCLVWJt0pFc8vO9OCm3SYtkse1DVCnrb2XKUJu72VTnXTsad36aXhKXnxV1t54
	 VFaIt4XfmIFgZBZG1mZ6QoZ/D3096x6BYybL4a1K2AviEXNRODVXJdp2kqLS9eH6cH0eQ
	 v5Z0g83h2hJXP+6Gl7dHGcHwwNRshOOynzKb6PyK6aZUp1X05uFK+fiUSQo9zkbm5qQ1X
	 bZUBAYQ7m9nr5Wmo1wWMOUlQjf8qYsBZlY0cmULpvgBAqHSFNTk2wR9dbz4FBMPWk5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11796606A323
	for <gfs2@lists.linux.dev>; Fri, 27 Nov 2026 04:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11796606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-574f8578e48so6690485b6e.2
        for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 20:33:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795754011; x=1796358811;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7rOhMtv2u2ZTS7Y7SzBLnz/8dNSyiaSieAM2fOven2w=;
        b=QbJYKzaWAVH6ouoGv7pbdb7jF35bGnq/TfEWn/dgKMf8RZSTU7SrsBgywXq48jR6je
         hqWWp7mxsxkxr2LDnMILPMBuaoSGQ8+Zlysohn3ZeUgwQgsD0z+O4VLMvPsL4Vaj4/Ai
         /IywQXZ/4xwgZIDjvxZ0njdrwcOUs864oRsaoyQdUf9V7yO6zeXP00rrICjrFTt4EjyM
         Z2SlR2g/cfm7wTf2E8KHOq5vq4Qj18pVNAnXslnb4msZkweB0Q7EZxY0unojEWCGL4pV
         VLZHp9fLoFTtCGJ1woUkWCRjO9aPT9zy+SZ+kefl559Cbw+G325pN1nFSz95V/RFMfh4
         u9Ww==
X-Gm-Message-State: APuU4Z/buDmThezB19yKM/bsjfFH4vYs82Oaehgq1txdjSlPL2riBcmC
	dfJSAQT1KtX+RxeLrwtNGRnU78rTiDTPwSxyb9rCF/yY8oHszU77Z0en1+X471vqNrFmTjCVaOJ
	leegFLR0KsLJAqh+la3JIe0GK668/033HAQNPCYQdfos9VGDdDbJ7R9CbHUA=
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f4d:b0:576:4f95:5305 with SMTP id
 5614622812f47-57a0ac32c49mr29972057b6e.38.1795754011163; Thu, 26 Nov 2026
 20:33:31 -0800 (PST)
Date: Thu, 26 Nov 2026 20:33:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6b09081b.904258e1.78503.002c.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Nov 2026)
From: syzbot <syzbot+list3a3ae45b81deecab1f47@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 0 new issues were detected and 0 were fixed.
In total, 20 issues are still open and 51 have already been fixed.
There are also 7 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 111     Yes   kernel BUG in do_qc
                  https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<2> 80      Yes   KASAN: slab-use-after-free Read in folio_evictable (3)
                  https://syzkaller.appspot.com/bug?extid=4c7590f1cee06597e43a
<3> 41      No    KASAN: slab-use-after-free Read in gfs2_ail_drain
                  https://syzkaller.appspot.com/bug?extid=84a21b16aba9f279d96a
<4> 197     Yes   kernel BUG in gfs2_quota_cleanup (3)
                  https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6
<5> 167     No    WARNING in iomap_writepages
                  https://syzkaller.appspot.com/bug?extid=5e659793378ad9e06387

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
