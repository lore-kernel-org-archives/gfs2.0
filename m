Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D491D7E26
	for <gfs2@lists.linux.dev>; Wed, 16 Jul 2025 16:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752681787; cv=none; b=KDfiYIwbAzpXv0IeyJVa1lxFdnzLSk9uJ4p2Ltib6Cp6+QPZdnE2qc1/zBO9DKqw22+DYS7kFTBiQhL8pePAu9WEXBCBHHhagr6CIkNv4Sa2DQLzmy2PG60Ua+Wptq2SQY4T6FoOc0syvAOyIJTifuc/RJj0fFtAJzZyPt8Cmmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752681787; c=relaxed/simple;
	bh=bqxdCCFCCrUXtUxtQnEDsH3+M0HCFkVEGUR5sVHfv9s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=buabdIWBI6F94mBiRcGkgeENw/85W4CKxYBjPy8CQJ2UoRbK+yeSLAF4E3Wk87jP+0vLupM2aU2YGXkLXlBNCtLip9K2owujSl2EBZms1ONO/LOguckvUj/abtCkn/jSm7AsXrQ2bZR92NdMR/f6LjMRZZYXsFbP1xrCLjuIk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-86cfccca327so682439f.2
        for <gfs2@lists.linux.dev>; Wed, 16 Jul 2025 09:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752681784; x=1753286584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wT63LkXL2c6/5tpyDkEqXffNBUYGB5pqpze4OwQMktY=;
        b=OAKNvvYghGCXJPVEkXD5lP1MeMVmrDQpcCXpJ9RQuTw2uZDj9oSZ1dXzL2x/qcAaub
         pWP3mwGZ2T1ovXbwIBY03Gh2WP2XlhCH53Vbm90DFY50gl95RmLUIjtAZP13LNOrUXU6
         t7fELuJdhOkzqviFjm/+VMgGbME78E0XNIt0OwIW4uV3TldsMtLAAjJWqiTlb2F1M5dz
         XvQJs2EViz6+uWavC+bgFLbF2wyEmieIHFcOtbg5QeY9pgypQx4MGV69DO5zC7fUoxQG
         srHBdNrmv2LZfIalSCBTt3845Avdw3vRQQvFdSvaUCKPY07PF6zR1oRRXzJ7Co6xX1qd
         mmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJ+n8MZ3Wp4Sb0wwjm/yxHZWBflloe/qVh8RoP5GknTzt/xYonura6Rii6G6IBoIuifV8l@lists.linux.dev
X-Gm-Message-State: AOJu0Yxeawguv4Zfh3xUcuXSQYtLhqjt4ZBZikOrNTU3vgp9SVjLuCWe
	NhnuBn7YW4r8RbaZVJ4I3seCEIBC0xCY/vqASLmB0GvYvg89T+Gb4NaD+qmzcLQyOmu34AZSj4P
	n18CLthW/jyvRfrP7LhwBlvU9USUcPId0LBbOEpXllVxvB2gpy4QeP7Cj1Os=
X-Google-Smtp-Source: AGHT+IHIbQON33vLWsMc15dMXHfcky/HD7dN7QTrQsyslSrLGsonYxe6t5WHvwIbLnaRTLkouGp2cBJJSXqicxEYOysAAwEAYQJW
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c85:b0:879:bf3a:4fb5 with SMTP id
 ca18e2360f4ac-879c093a7bdmr468060339f.12.1752681783800; Wed, 16 Jul 2025
 09:03:03 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:03:03 -0700
In-Reply-To: <0591ddb7-d279-4b13-bf2f-ffb913e82720@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6877cd37.a00a0220.105e77.0002.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
From: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
To: agruenba@redhat.com, anprice@redhat.com, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com
Tested-by: syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com

Tested on:

commit:         557c024c gfs2: Validate i_depth for exhash directories
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1125458c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
