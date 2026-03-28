Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B43590CD
	for <gfs2@lists.linux.dev>; Sat, 28 Mar 2026 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774718622; cv=none; b=dGxEN/KWh6pGHC+7d6fRIImtAXsOyoQxX4ppjCn0Bmjsfz19eb5BUVduXXvLsrVO1eU4FinNy7Z10eDuvZYpO1SA6mhKwb1O3i9PNCB9OLaLfZHmKNUfxRIAtUwcj6fF8JARvX7DhutR2scWbi3WIIK/wLTwKJoT7yyw4aplcCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774718622; c=relaxed/simple;
	bh=WbXqvQhn4qwD4XjOM1f/RolmfvXydvP/QpIVZ5/s984=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQmXL9gWQ/dhqFlvS+w40dRC6gVNdlqMg3Q6l1KC5EEwerNrgwcY/IPds+FsjYp4QMv9dsiN/hbyfn+eHYSOyNXeRvzDZiwSPpRaBTDpKAEfDIw3ejdvQRC0bB3okfhw5mx9UONEgt1MUtoYG1yKy1EHZaLyiR+nXn7tYwQ0OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q2iTtPbM; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2iTtPbM"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35c238f1063so1520065a91.1
        for <gfs2@lists.linux.dev>; Sat, 28 Mar 2026 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774718621; x=1775323421; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=Q2iTtPbMMh9PFX0b3rbpndxYWx9zELWU90TUh0mxc/npmB61bfb5QDG0mv3msCakCt
         17qRRQmU6nXt8aKbQT8d89jLK8QxVqVvxdbsc1J7s5U9t43HWzsxNCYKX8eb5AfZT7XI
         yb8EPKpKCZQh4u2h5YnPcs0Y3G1/JMYlaos+WmaqdZnHMHZ5e5Wx96Hy7e3Oug6LVND4
         A9nA46ywG1SJPP2jRH1OrOOGOeHe6EhIWQi9pwhg+IRJS/BpZEZfA3habqQ8g0w84q78
         rpJtKOTai+xE9ruWxAKBEy3LJHShpA12zFo+RBlgHnVfNjngttW6D78P2FcrQNnLG8pc
         Y1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774718621; x=1775323421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BNS/xpL/hsal7ModqBYJCvXhQFGlskOPOCno4hyw7aY=;
        b=MGDQ96XL+L6dkXzTJw+aqlSaUA0dLhMPDsu/zDPIve6KZ4mjgA56PkrocYAQLPKuq3
         CtbLvOGbvR8ejHuuCrmvK560qR9xdzcLByMhRiRQuf0fimCAVVSlJSNZndysm+oq8FTw
         4A5fBfYaYb0/7qFhDNEo59WsWZ2qINBJKqqBhLDuQUX2FkoDWKSfSp2WEt6LXK99xVaq
         c5YXY7KSF06jZksBN9q7WCN1zmChEV13tA/KU/v3KnGy7xGCYFT3RPe68AyANwszwP1K
         +sfnOazIehf04mWiUmbg0mkgXdD4mACHNZMGNhgOzykRXnyAP5IAID6bYoSFIGlVSv/A
         K0cQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZerlGya7cIS+K92xoHKSlhl3wHaRKgKq06dZv/vsCHbhmSpGQrAgP1rGl/cE5SmzoveFM@lists.linux.dev
X-Gm-Message-State: AOJu0Ywql6M9FUkmXIrCd9nvufPXVcuf7avTk6zn+6lvNRE2UeeztJb5
	d0pkb8JaaYv5Vfms/eTC8k1pas+wheqXl2JnU3NVWIGlEpqKr5XOHuun
X-Gm-Gg: ATEYQzyOebbtgOKqDldBykUVTZX/k2QwW7vUmqM60McuHAhkii7JRjgWslDU7giFEnH
	iHdAu+TGi+6ZpklJtingNps3uKNg1+ilPPmfgD2Rc5SzVBmwR2h0OroWEc2gH6FLQZHInrKhGWk
	wUT8vr3XArBh7xUDmAyZ4cycvIOzR1VDTdTA5WjrPdXThfunVzzFcIDXLhDA7PCcrRZcYlQYY+h
	8EeygRvjsZfnyqRLKH09eUDz93qrKtz7OI6uOz0MVLsef5PeLi+YEYHPSlCToMSRHAYQOTW8DIe
	W/i/JTkSABalI3b25RkiF40/Q30C5ifXi5/D1VZgwuohA6815goMYjARhx8Wme4E83C40SCsmjm
	/ZBQqU7ngoyEVmhlq/H8XZzw5NkBGqFzfw+jp82q1dS1UbaX6VqwWTaE9uWILAFBYKWJ6jVAz1r
	Jnx+au/lmZ2ceGoIDzvLQbDjbKKR1Uyr/zWAK5aBsSyKdr4m/eAfyfQbY=
X-Received: by 2002:a17:90b:2744:b0:35b:e690:c5ad with SMTP id 98e67ed59e1d1-35c30094a5amr6635171a91.25.1774718620730;
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
Received: from toolbx ([103.103.35.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a5570esm10513773a91.3.2026.03.28.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:23:40 -0700 (PDT)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v6 0/4] OPENAT2_REGULAR flag support for openat2
Date: Sat, 28 Mar 2026 23:22:21 +0600
Message-ID: <20260328172314.45807-1-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I came upon this "Ability to only open regular files" uapi feature suggestion
from https://uapi-group.org/kernel-features/#ability-to-only-open-regular-files
and thought it would be something I could do as a first patch and get to
know the kernel code a bit better.

The following filesystems have been tested by building and booting the kernel
x86 bzImage in a Fedora 43 VM in QEMU. I have tested with OPENAT2_REGULAR that
regular files can be successfully opened and non-regular files (directory, fifo etc)
return -EFTYPE.
- btrfs
- NFS (loopback)
- SMB (loopback)

Changes in v6:
- OPENAT2_REGULAR stripped from file->f_flags in do_dentry_open so that it doesn't leak in fcntl(fd, F_GETFL)
- BUILD_BUG_ON updated to use VALID_OPENAT2_FLAGS instead of VALID_OPEN_FLAGS in build_open_flags and in fcntl_init
- v5 is at: https://lore.kernel.org/linux-fsdevel/20260307140726.70219-1-dorjoychy111@gmail.com/T/

Changes in v5:
- EFTYPE is already used in BSDs mentioned in commit message
- consistently return -EFTYPE in all filesystems
- v4 is at: https://lore.kernel.org/linux-fsdevel/20260221145915.81749-1-dorjoychy111@gmail.com/T/

Changes in v4:
- changed O_REGULAR to OPENAT2_REGULAR
- OPENAT2_REGULAR does not affect O_PATH
- atomic_open codepaths updated to work properly for OPENAT2_REGULAR
- commit message includes the uapi-group URL
- v3 is at: https://lore.kernel.org/linux-fsdevel/20260127180109.66691-1-dorjoychy111@gmail.com/T/

Changes in v3:
- included motivation about O_REGULAR flag in commit message e.g., programs not wanting to be tricked into opening device nodes
- fixed commit message wrongly referencing ENOTREGULAR instead of ENOTREG
- fixed the O_REGULAR flag in arch/parisc/include/uapi/asm/fcntl.h from 060000000 to 0100000000
- added 2 commits converting arch/{mips,sparc}/include/uapi/asm/fcntl.h O_* macros from hex to octal
- v2 is at: https://lore.kernel.org/linux-fsdevel/20260126154156.55723-1-dorjoychy111@gmail.com/T/

Changes in v2:
- rename ENOTREGULAR to ENOTREG
- define ENOTREG in uapi/asm-generic/errno.h (instead of errno-base.h) and in arch/*/include/uapi/asm/errno.h files
- override O_REGULAR in arch/{alpha,sparc,parisc}/include/uapi/asm/fcntl.h due to clash with include/uapi/asm-generic/fcntl.h
- I have kept the kselftest but now that O_REGULAR and ENOTREG can have different value on different architectures I am not sure if it's right
- v1 is at: https://lore.kernel.org/linux-fsdevel/20260125141518.59493-1-dorjoychy111@gmail.com/T/

Thanks.

Regards,
Dorjoy

Dorjoy Chowdhury (4):
  openat2: new OPENAT2_REGULAR flag support
  kselftest/openat2: test for OPENAT2_REGULAR flag
  sparc/fcntl.h: convert O_* flag macros from hex to octal
  mips/fcntl.h: convert O_* flag macros from hex to octal

 arch/alpha/include/uapi/asm/errno.h           |  2 +
 arch/alpha/include/uapi/asm/fcntl.h           |  1 +
 arch/mips/include/uapi/asm/errno.h            |  2 +
 arch/mips/include/uapi/asm/fcntl.h            | 22 +++++------
 arch/parisc/include/uapi/asm/errno.h          |  2 +
 arch/parisc/include/uapi/asm/fcntl.h          |  1 +
 arch/sparc/include/uapi/asm/errno.h           |  2 +
 arch/sparc/include/uapi/asm/fcntl.h           | 35 +++++++++---------
 fs/ceph/file.c                                |  4 ++
 fs/fcntl.c                                    |  4 +-
 fs/gfs2/inode.c                               |  6 +++
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 ++
 fs/open.c                                     |  8 ++--
 fs/smb/client/dir.c                           | 14 ++++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 24 files changed, 131 insertions(+), 35 deletions(-)

-- 
2.53.0

