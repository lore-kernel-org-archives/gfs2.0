Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D93416631C
	for <gfs2@lists.linux.dev>; Sun, 21 Jul 2024 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721599864; cv=none; b=vATjrVGaCQ5ReJfFFzqW9av/kZMbdal+22wEIC1O/NE3kVpc9LygJm+7l2OU2Xs+X93AZiBW0R+NlB85N/hXfZzBp2cTiPMMyFazUXo/48FtXWqLspkP9vmiVtRki0e2NYkXURu4esfziMPmngjgKujz4Uhc/FksJkNi5Ud4IUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721599864; c=relaxed/simple;
	bh=ROuYac/v7HvupO/ZKKFWMQblw6xDVtj71Yh0bJWBPhM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EyGoM0KVmI9fZ2H4wqYNxBbuQPdoqbSxhWQaKZHQ3KsCAYVBCGVJ8s0LXQtVceq9xsSu6isGE3Bu40AMQ/FuKnGh2FYXv5+wggKmtG3Gt3wc4QwznxdAcqQGcMj73I+bsQrQkXVEmoSWFalsdsXUsAfc4y2BN5rMcW7gO4rciK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8051524c1f8so620939139f.1
        for <gfs2@lists.linux.dev>; Sun, 21 Jul 2024 15:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721599863; x=1722204663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/ElcXLSEs+o1vvYpa3l7nSiB+TQAeaMdVYMGYY04DA=;
        b=Y6zACfXt2BrGEXaoyEl3DBTbt4bdlaTOUJ2jp90tXT8SLFB7iImDmW5d3pekpjx7tD
         VDBl8qMBkmtrldLnSmvezGT5R1Ukjep4d7SBHt7CYLny2SOg3VoTMscU4SB1lTxFVRJf
         D7gmb0rk2Ivojfme53QxjMLntSQNCqKrIf2/4M+0SoFEAhXeoir7hKsW6hby7qQDEmPS
         Mf/T6pmSR68U32vzsZalZKwXX/bfitH7RaaWvJSzfPFBx32ErEPF6NMyufGUMCYbWt8P
         0Sg4ICh6u5jydPGEIjopGKeACa0642T9JH4RFWzODRxqoz3bsO7W8UxjwttXl3EtSL+T
         YlNA==
X-Forwarded-Encrypted: i=1; AJvYcCUMIyoDk4xojBrcR6Un5GpGR6wbVs6X+SlYjp25CJl8ORqKqAwbrIXHxueQHLaDPYG+v2In9lx/In3YOPWDi5aDm0odpA==
X-Gm-Message-State: AOJu0YyX7C5t9oHrsO5lGLUOrjnVOaSX5wa33Za9av9mq+DsD37HsP9C
	0rCjgtmtPWNUXQwxuQPYNSUQuXMCRDWWMNsOnaUe/477N5SxBdGWg70ToObF32QITsXLVL4tRzf
	Sqaw/6CyBrDiZLeUYxu3b8PgkBXDa/iYxV13/LmaYGLXddU5sTZkPgu4=
X-Google-Smtp-Source: AGHT+IFwlqPBP6jWzZoW3rXuWMFQh7FGBhuuytJsPLPAnDTKR+xV7i3/zG+COlCuJ9KX+tHMpHzb43pblyAGQqs+ies1faZTIBDj
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2395:b0:4b9:13c9:b0fb with SMTP id
 8926c6da1cb9f-4c23ffdacafmr276882173.5.1721599862798; Sun, 21 Jul 2024
 15:11:02 -0700 (PDT)
Date: Sun, 21 Jul 2024 15:11:02 -0700
In-Reply-To: <0000000000002501960619e2366b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004485fa061dc93442@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
From: syzbot <syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, hdanton@sina.com, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 30e388d573673474cbd089dec83688331c117add
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Apr 11 12:13:30 2024 +0000

    gfs2: Switch to a per-filesystem glock workqueue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13653eb5980000
start commit:   523b23f0bee3 Add linux-next specific files for 20240710
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10e53eb5980000
console output: https://syzkaller.appspot.com/x/log.txt?x=17653eb5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16907bb9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ce66a5980000

Reported-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com
Fixes: 30e388d57367 ("gfs2: Switch to a per-filesystem glock workqueue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
