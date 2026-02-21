Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C33563F1
	for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771693262; cv=none; b=OjnkUzww22eAxpc8dSWSC1sLwshsXeyA9fELsS1Cs8hHHRns5OntEPRN4YiIpkMWE5p6l9RVXapnWas79VAf3i/ehZ8QVG4mppTXJil0pDQrmFRrmYZZytXZb3QFiDxo0dgjSqeeB29wWH/DNI0LFQsnPtKDbyZa7Jdz7egAW+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771693262; c=relaxed/simple;
	bh=Q8LjG5w0LfBzA+qqIJUKX9oy/FN75Vn0W7VHoH69Qv4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgC8Ee5AFHITU570FwjVEN7aR9hsxHbgG/7f5z6OfR7ECVjW5KHYYFYmt9xIVcSA8mNBMgcgTRBwOMYHApo9Wg1/B1rIMW2vm6h1mkxtUOwgA6aq7Uj7SHBTZtbDNvjERa9aBAsIPgi5Z+52ftl+yjuNJ8ZggW0ZynyTm3m6mBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPtHK37Z; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPtHK37Z"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5670ea44187so2435983e0c.0
        for <gfs2@lists.linux.dev>; Sat, 21 Feb 2026 09:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771693260; x=1772298060; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=LPtHK37Z3W/N2EntEVW1hKM6P0brJBF8v8p0urHtJDSPf4XmbX9ZPtt4fcv3z6WFJm
         4qmwAz72QI/cWwJf08LBhljIAHC/zqeDasthKLLiY+0ec+KKmu8r/kf+UhZOAFqHOYEX
         eGLZJkOGVqhORK3t8DBo/Z0tYaZTfVTS95CqAqIw29sYs0QKASxAkIIjzH/v7g7kMzfj
         Wnrq32c/jBE7Hwo7dm9PXS5VhbfCze1RGAEmtYDGZbvXeD1jLbGMB0uUkLsGBqQU/mo0
         0bJKCI3Qu8BJDE2fhCbkOJAVPFddlqoRtvIyFJ7GTJJuy88SBMa0BropO4PtlQpHWr3N
         gcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771693260; x=1772298060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchZpIBGjK9hFXqFYovVVV/bmoJVWZnsrs7zJJ1McUQ=;
        b=j5D7mkdKeUvbnBAMaIISPMvdY9IPYaLuhquds0zD8xyqgt3PPBYac0of1WDFUoD7r/
         WaQXHOkUeek/AgLbxT1VRADd4tosWRVN+UMO/4QqYHMZ2PkWUhMijnKXBISZJhCh+NRS
         pDt+NZsC7fXY/cU0eEDQiMaA0+fcJ7kk+oMsUH+y9YqYz9FyenUAZpOiUSHN14UOcb7o
         RupeXfwUqUvhEECKxtpJIWbmTJjxw0JP1wR8lpK2eLJeFS33ULH9JpwWQtx3fs8qA9aO
         8jR47lJBRtN/+KEeIoEnPoN2E7MzP94Wwcq/gnv55XuWfcsKMYq6YKokDS79c9yTPF2Z
         ZAOg==
X-Forwarded-Encrypted: i=1; AJvYcCXfTNf30r0IT8VXeVHjQhXt92do7k98pxdxj+dobJRv7kEQhrwfXo15agSjvq7W6MVPalaN@lists.linux.dev
X-Gm-Message-State: AOJu0Yymc3XlU9EEIagyMZuASl75NTUI4JCeeaxZE+Ts+9nTJ/Q1m6CP
	nBYg99WtcopP8gwK9Duz/1lfZwFFhOjiONercFcgZmKi7jrdgJL96XqbJUV18w==
X-Gm-Gg: AZuq6aLNLRrbeXT14gFix/9kF1W/OkaN8xW6wcwIFNY6zNcn4RC4CVLrMw8lwn6qP1+
	MWS0fb8n7zWT7NSah3mMEO0by23vElqdurNESnee37RxGzpeQaicF7IDSUkYKrCwdBhI8Qhem25
	T2Rh+J9xMNoPRlKba0Hj4VjIvEF0Ce29K7GQ1l593pfNtoMX/7zK3rdN5e6wd5us+g6FDywAUXH
	Hixzk7IZKyr7q9/yqcdnqc149lJAozUBf5Jo5dwk7k9totC+0vG4NBfvjXhCY+siqvS7NVNLiLP
	wa+HdETCPK/CPW5eJIyVsnAf3oQwYItuEGX42GthhwB4G9pYLCD3qkyT8iL0mwF/oKh0VXxJ8Va
	dStpaVKjds2D9/D9T1ygsBD6skF8ncIzPOkQt3/K6YScZT80s9x8J1TgXdPsDmjW+G8OM4qaZbs
	tufVmqztwKi06lV4HichCGicT4NiF+PJ6RtGLObrrP0yybXfzw7E7iD1I=
X-Received: by 2002:a17:903:1d2:b0:295:24ab:fb06 with SMTP id d9443c01a7336-2ad74458fa3mr31285505ad.22.1771685983010;
        Sat, 21 Feb 2026 06:59:43 -0800 (PST)
Received: from toolbx ([103.230.182.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad7503f4a4sm23730205ad.79.2026.02.21.06.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:59:42 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
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
Subject: [PATCH v4 0/4] OPENAT2_REGULAR flag support in openat2
Date: Sat, 21 Feb 2026 20:45:42 +0600
Message-ID: <20260221145915.81749-1-dorjoychy111@gmail.com>
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

I only tested this new flag on my local system (fedora btrfs).

Note that I had submitted a v4 previously (that had -EINVAL for the atomic_open
code paths) but did not do a get_maintainers.pl. It didn't get any review and
please ignore that one anyway. In this version, I have tried to properly update
the filesystems that provide atomic_open (fs/ceph, fs/nfs, fs/smb, fs/gfs2,
fs/fuse, fs/vboxsf, fs/9p) for the new OPENAT2_REGULAR flag. Some of them
(fs/fuse, fs/vboxsf, fs/9p) didn't need any changing. As far as I see, most of
the filesystems do finish_no_open for ~O_CREAT and have file->f_mode |= FMODE_CREATED
for the O_CREAT code path which I assume means they always create new file which
is a regular file. OPENAT2_REGULAR | O_DIRECTORY returns -EINVAL (instead of working
if path is either a directory or regular file) as it was easier to reason about when
making changes in all the filesystems.

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
 fs/gfs2/inode.c                               |  2 +
 fs/namei.c                                    |  4 ++
 fs/nfs/dir.c                                  |  4 +-
 fs/open.c                                     |  4 +-
 fs/smb/client/dir.c                           | 11 +++++-
 include/linux/fcntl.h                         |  2 +
 include/uapi/asm-generic/errno.h              |  2 +
 include/uapi/asm-generic/fcntl.h              |  4 ++
 tools/arch/alpha/include/uapi/asm/errno.h     |  2 +
 tools/arch/mips/include/uapi/asm/errno.h      |  2 +
 tools/arch/parisc/include/uapi/asm/errno.h    |  2 +
 tools/arch/sparc/include/uapi/asm/errno.h     |  2 +
 tools/include/uapi/asm-generic/errno.h        |  2 +
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 23 files changed, 119 insertions(+), 32 deletions(-)

-- 
2.53.0

