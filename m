Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70511A38F9
	for <gfs2@lists.linux.dev>; Mon, 24 Nov 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763945825; cv=none; b=IHPXiI8tJvwK41AVTzG6hcFjD9l+hjtWrU4iyc1U8aRT20mqSkGvOJic5/06AvpY5a40Bdfl5+cveOQAx8KZlK6GOe8i0H2WRCy6AnDA+OGhOptXTGcVN+NWUHkbqWlTlO5zuaYpalj1mOU9jGYDm06SKYZUwOYuC+TTuBv9G9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763945825; c=relaxed/simple;
	bh=dpCiPzAIeVgX5++J/5+WfZ2c/FVoGFonloJu10MAfFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WnrmpOdozYK1Q6b075ETem4lclGxI344wFukThk/xP1VcoGalQTHe0mli8nUJNuyOBppI4oC7KfSk3PSI+3Dbi9eHUGV90p56OxjrZDcWvKCPQATg21wZB+LqfHhPp7bmGP2+JezO8VYl3mMH4saWfkMlQQtfopsmlvdRQnUK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-9487df8723aso270501039f.3
        for <gfs2@lists.linux.dev>; Sun, 23 Nov 2025 16:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763945823; x=1764550623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/4fCOC4PpktK3rYrYe8yxO/WowO2dsX2aVI3vzm/Hk=;
        b=rHsq0U536kj+iQR0ZEP6YQZbisn1njeYRukgIFeVJX/gdkckGeTYThM9IiWjCsR7+7
         vyWxohNhCBuxtO6YBmjGan0k9kWvgWapV/oW/ZDb9h71XmhqeBkgRZDIft+dXSyuPlsh
         oCxFCaTE47J1NqoTDZfjFFCfF1N0MoP7okVK+MPHjwU8kD5UshI9aAFRI3lgDFr0W6Yq
         KOwbciDMQ+RcPJ6fQ+JOu8zOBdJWaN2PbWlgPVUZWFELSG7Bai1kYnHaIO/H97mvL2Op
         TrMiMczc549cxJyqXkqz8pBh3mVqpxRV6HHZ3eAvjFEseJUpsY1OArJriHr3A8k4pL2F
         h/PA==
X-Forwarded-Encrypted: i=1; AJvYcCU4qNb4lmuiJQmKgT0mC4Iu4b3R1gZ5m0INjilCEPqZo1dAuw/npWKSmkyMTGDUJjuQsQ54@lists.linux.dev
X-Gm-Message-State: AOJu0Yyg1GHHvMXRdmS/PDp+As8LwUQStfDBjKXESbIB8hFO6e1KsxVZ
	8QQqc4ejX+MdSQ8+hR4un21KdDQWS5tw1/2gOmU1q/UfrnSYRx2BXICtflQEhB8rDIhxOsEtJY0
	r8Aqx0otBJ6g/fFCaN5BKL5psXWvhXGwAZA3AwzrcX0gOqK3vbJMnqRCKX8o=
X-Google-Smtp-Source: AGHT+IGDPJeEfOF4zHJaIy56M2IFQH/x2aTvGnfAbNijVQ5EyaL/z4SquIw9K3hsr4+SARQmeqYdjSBb3AaU8xegrWbXWCIsBGSe
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:434:96ea:ff8f with SMTP id
 e9e14a558f8ab-435b98f0a6cmr78245265ab.39.1763945822935; Sun, 23 Nov 2025
 16:57:02 -0800 (PST)
Date: Sun, 23 Nov 2025 16:57:02 -0800
In-Reply-To: <6q2lk36d7ylpqu2vyb3tonxniebiwdhdygbudoi5osmy2ebdtx@4luyu7tw46sv>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6923ad5e.a70a0220.d98e3.0072.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
From: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Tested-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com

Tested on:

commit:         d724c6f8 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3d8b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1347d612580000

Note: testing is done by a robot and is best-effort only.
