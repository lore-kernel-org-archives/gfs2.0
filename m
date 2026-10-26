Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793046824;
	b=A0GfUDK1dkMJM7fiUqEflfkYzIZrlVBK7FGvM1uwCEM8//JJKq/fFvsTDnfx4dde322i
	 0wUfu5uh6qFRr0e0GD/kfWTdibhR+iQmILOhpSDnKJaBJs1fR94To965aiVNLoZcDW3bT
	 D3hcTw9oM5zN0gX3q1hyKUxXrjUiVmtYmcnkswZIjDyZaTEBFeg+plxfuVIx9cfhxFD87
	 3Ci2EuTTUgT3QuY3Dl7SBXwrZUStlUHtR1mtwvQhgz/2azdeR462/0eY3x6GxA61A7V5Z
	 VwLhDzwMQKnkfTvQ4dmBugpiNx3PmzQwrX0IjrdlGGXDDnUAShy5YuLip2U/BqEwq7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793046824;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=iRccZVeCNKdc/8T/FzB99LACl98McbT2PAYi2Bpn7WM=;
	b=BUzykMKW01QrevbczG4V/hdKvwCTpLqSKeAYl/MMub12qlTyu+af2Ay8/UI6bbpYdRzb
	 IsyksMWi+wUsEEX6NEHR8bB/qBZvabWyMVO+Leuxs3rQxafEIrukdwbhiN8PZ6Fea9S6y
	 cngL6/DlkoveN5WWhHv9J/eiZyeLmqCwExQvJ+L7M9ZAPnCt0qiZcmv0cTMhGv+RzuqQk
	 HhbfbFMN46DlUEraMcZhpncIRcax3kdpaJrSwjYva+qp2AUKHV8AZXln7ui1rZmUBI4SO
	 lZchWA84hj09VxBcTHD2qDjvSdbJELzBpBg1r44H9K6gxdvPYzddSxggs781Sxsx4Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.197
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46847606A324
	for <gfs2@lists.linux.dev>; Mon, 26 Oct 2026 20:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46847606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-5587351d419so2838469b6e.1
        for <gfs2@lists.linux.dev>; Mon, 26 Oct 2026 13:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793046823; x=1793651623;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iRccZVeCNKdc/8T/FzB99LACl98McbT2PAYi2Bpn7WM=;
        b=R5KmaBzXQ04FfxSV+GNjQDEYe+JDYM26RivfTLr2QuiCT192Z79tUuI0rDMqbwxNKS
         WOWB2BgsdPUxtNQ3vaHHPJBZsxxOyazicxz1h+qF23G6SKhXd0b3oK982+/WU36i363c
         7pxLKHpSZe6CgjGLRZ3Fuu5zILLqVlftP70EsOSgXinpDcOD1mLZTFcjr7I/Aa9+2MbN
         ufd7GZ/TbNemnO80KR4k9YbqEzukrD8dT/RHhEACUpSbD9xQLwvFR0tIiawMXMoF2TUl
         3oJJOD39tJZcSc8Iv5AElqVXwOmj8R3sUuI2fc9BIcvjJvMQHI26+Y6t1R2Ux3r3EvnR
         w/JQ==
X-Gm-Message-State: AFq9FYI1RoQFf1+p8JxR5gU85AE8Su1O7tGr8eJyB7C//GR2BAZJp2Bq
	QB/R15LL9E42OF1mea9B9vak4iwP+iLPcSKvxczqwn4XFcgMWauTBVNX6JzImzdxeUhI6m+8sto
	nBhQ0ovH1pMuITSTSckJBocrN8PoLtX8MghscBniyNBqZ2eX9dYVj/4DsSxs=
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1819:b0:539:596f:6623 with SMTP id
 5614622812f47-55c0035e613mr5083540b6e.64.1793046823318; Mon, 26 Oct 2026
 13:33:43 -0700 (PDT)
Date: Mon, 26 Oct 2026 13:33:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6adfb927.3a3d6196.2ecadf.0020.GAE@google.com>
Subject: [syzbot] Monthly gfs2 report (Oct 2026)
From: syzbot <syzbot+listff7b9f36ba634c9915eb@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 1 new issues were detected and 0 were fixed.
In total, 23 issues are still open and 50 have already been fixed.
There are also 10 low-priority issues.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 163     Yes   INFO: task hung in do_uevent
                  https://syzkaller.appspot.com/bug?extid=b114bbe890d76037877c
<2> 108     Yes   kernel BUG in do_qc
                  https://syzkaller.appspot.com/bug?extid=bad65435361712796381
<3> 79      Yes   INFO: task hung in gfs2_recover_journal (4)
                  https://syzkaller.appspot.com/bug?extid=9013411dc43f3582823a
<4> 62      Yes   general protection fault in gfs2_glock_dq (2)
                  https://syzkaller.appspot.com/bug?extid=5a5f492ccae698fd7434
<5> 57      Yes   WARNING in gfs2_ri_update (2)
                  https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74
<6> 36      No    KASAN: slab-use-after-free Read in gfs2_ail_drain
                  https://syzkaller.appspot.com/bug?extid=84a21b16aba9f279d96a
<7> 182     Yes   kernel BUG in gfs2_quota_cleanup (3)
                  https://syzkaller.appspot.com/bug?extid=af4d53576692f8956fd6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
