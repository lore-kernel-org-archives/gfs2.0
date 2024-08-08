Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62977157466
	for <gfs2@lists.linux.dev>; Thu,  8 Aug 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145301; cv=none; b=RpP+P05qKe/+32mOVnGu559K8RtlR1j4HVoVYdQvYTL3/kLDCWfQWOkbd+R5IghVSIQ36vlHW7zdRWAa7wNux/A15iECwSXxPUvpWYDKzWIHcuP5288W5hY6/IRwiOheT4+7KLQTgLY4stti+7Lv1D299H3pT1wQs4e5ulNa9cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145301; c=relaxed/simple;
	bh=moGq7PvzGvB0S6UQMZuwnIDOkPknvOA1+Hh9JdRtibM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Q+a+R/3CgMp/xospULwU/3el0a1dzAdtye5jpaomFqLhmGKJy1qIIJLKh/RBtOPrnSFNX0rTTNuoecST4mfkWGtj/je+BrcLvDLC8BQ/CFTufFeDJZfIPcqieLb95Vhx6JrXpgQGYuxKZ3My8luBeIMwBfldGXB2aPdmgjBqucQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=cvCke/gr; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="cvCke/gr"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7a1e0ff6871so78823185a.2
        for <gfs2@lists.linux.dev>; Thu, 08 Aug 2024 12:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1723145298; x=1723750098; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=agwST92yUhpv2dWxzT9/pEGlKDn9gtYgiwLWoC5Trsk=;
        b=cvCke/grXNWYyML6wTZQRNayPyYg8QU5QqtI6aiRN78gIwY3P5XVOzVURa1aE3fJSl
         2pAhwXBIVA3lOXuPHPXmRGdh1aeCU6C2WIKCviP8LWphGPxhXTZN/tBZu5ipsgxEvDZE
         Ju5ek4sD6iCEtSrWRKz4WTEZx0S5xJfNNDTWaEPQxlz1UxJcMbI+c+YVfVTRMHO3AcKV
         nePjyb/Sz1WxUL4Hm2KDchAMnmTr5QlFr2F4CqLm5AxMOVklY68jhXhkJeq/FV9GQs9g
         UtwJDbUpAFNY+qYcIIRHJ9yPLQt8GM/Xj+qsC91IFgQbVkESjWxuV2BmQukh19ltKJdK
         fQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145298; x=1723750098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agwST92yUhpv2dWxzT9/pEGlKDn9gtYgiwLWoC5Trsk=;
        b=Fc4PHMy5hYyPAY/e0IUJgM9I3Y284R7qm7AtVuMRcPotpWxqw+Eg1EIbuEf1lSK/nD
         LxJCAsGcAIMcT6RyHnpO4DVcbrAkBCJ8yjJ+q1f+m4IObO0fD7mXE4w2/K25GA69usBA
         NtzOHCsg+Nydz9438+HDIgrVjMX4XlyrN1ZHI91kSSyJ/F/vNkf9j/msJwtSY2snjeda
         xmrjmbYBsyhOHqoE5RYtVQm+jDsGLQUbp9bzPPPxFhg8IjY6W52/en2UoINAFOU3M7tG
         JX9EOsF4pl9F0hg090ahLzUWZsTG4dPdrsad4R6pdAlTl5jHO3cGw2mDQ2G/nPiuHXf2
         pLIA==
X-Forwarded-Encrypted: i=1; AJvYcCWi7dFmUwjtdDd8Dx3x0Q9DTYMSrA943GQI4QQpnEodlwPIT7VEzRaj8DfAg+oOdHqLM4hlT/P5mV1aAZ0yNIssVDyS6Q==
X-Gm-Message-State: AOJu0YwfYCZfbZgTPDShZ/ecllX5Qk5LySSMq8bMVV9Ggaw9jAiCVuEN
	3YJDalaE5nn0LpSU49RPIFfUTabhzkUD9xcpF+VOc5bB3l2rU6zeh+ClmOss6nM=
X-Google-Smtp-Source: AGHT+IGGxHal+nvm3DWblQGxQewjVvUB+tmtzj67hYOald+f6l1Hj85ZVGGxy87PgKyA6cAN7fLx5A==
X-Received: by 2002:a05:620a:4515:b0:79f:436:7e3a with SMTP id af79cd13be357-7a381872787mr341626485a.48.1723145298198;
        Thu, 08 Aug 2024 12:28:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785d2a3csm189653585a.18.2024.08.08.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:28:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: [PATCH v2 00/16] fanotify: add pre-content hooks
Date: Thu,  8 Aug 2024 15:27:02 -0400
Message-ID: <cover.1723144881.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1: https://lore.kernel.org/linux-fsdevel/cover.1721931241.git.josef@toxicpanda.com/

v1->v2:
- reworked the page fault logic based on Jan's suggestion and turned it into a
  helper.
- Added 3 patches per-fs where we need to call the fsnotify helper from their
  ->fault handlers.
- Disabled readahead in the case that there's a pre-content watch in place.
- Disabled huge faults when there's a pre-content watch in place (entirely
  because it's untested, theoretically it should be straightforward to do).
- Updated the command numbers.
- Addressed the random spelling/grammer mistakes that Jan pointed out.
- Addressed the other random nits from Jan.

--- Original email ---

Hello,

These are the patches for the bare bones pre-content fanotify support.  The
majority of this work is Amir's, my contribution to this has solely been around
adding the page fault hooks, testing and validating everything.  I'm sending it
because Amir is traveling a bunch, and I touched it last so I'm going to take
all the hate and he can take all the credit.

There is a PoC that I've been using to validate this work, you can find the git
repo here

https://github.com/josefbacik/remote-fetch

This consists of 3 different tools.

1. populate.  This just creates all the stub files in the directory from the
   source directory.  Just run ./populate ~/linux ~/hsm-linux and it'll
   recursively create all of the stub files and directories.
2. remote-fetch.  This is the actual PoC, you just point it at the source and
   destination directory and then you can do whatever.  ./remote-fetch ~/linux
   ~/hsm-linux.
3. mmap-validate.  This was to validate the pagefault thing, this is likely what
   will be turned into the selftest with remote-fetch.  It creates a file and
   then you can validate the file matches the right pattern with both normal
   reads and mmap.  Normally I do something like

   ./mmap-validate create ~/src/foo
   ./populate ~/src ~/dst
   ./rmeote-fetch ~/src ~/dst
   ./mmap-validate validate ~/dst/foo

I did a bunch of testing, I also got some performance numbers.  I copied a
kernel tree, and then did remote-fetch, and then make -j4

Normal
real    9m49.709s
user    28m11.372s
sys     4m57.304s

HSM
real    10m6.454s
user    29m10.517s
sys     5m2.617s

So ~17 seconds more to build with HSM.  I then did a make mrproper on both trees
to see the size

[root@fedora ~]# du -hs /src/linux
1.6G    /src/linux
[root@fedora ~]# du -hs dst
125M    dst

This mirrors the sort of savings we've seen in production.

Meta has had these patches (minus the page fault patch) deployed in production
for almost a year with our own utility for doing on-demand package fetching.
The savings from this has been pretty significant.

The page-fault hooks are necessary for the last thing we need, which is
on-demand range fetching of executables.  Some of our binaries are several gigs
large, having the ability to remote fetch them on demand is a huge win for us
not only with space savings, but with startup time of containers.

There will be tests for this going into LTP once we're satisfied with the
patches and they're on their way upstream.  Thanks,

Josef

Amir Goldstein (8):
  fsnotify: introduce pre-content permission event
  fsnotify: generate pre-content permission event on open
  fanotify: introduce FAN_PRE_ACCESS permission event
  fanotify: introduce FAN_PRE_MODIFY permission event
  fanotify: pass optional file access range in pre-content event
  fanotify: rename a misnamed constant
  fanotify: report file range info with pre-content events
  fanotify: allow to set errno in FAN_DENY permission response

Josef Bacik (8):
  fanotify: don't skip extra event info if no info_mode is set
  fanotify: add a helper to check for pre content events
  fanotify: disable readahead if we have pre-content watches
  mm: don't allow huge faults for files with pre content watches
  fsnotify: generate pre-content permission event on page fault
  bcachefs: add pre-content fsnotify hook to fault
  gfs2: add pre-content fsnotify hook to fault
  xfs: add pre-content fsnotify hook for write faults

 fs/bcachefs/fs-io-pagecache.c      |  13 ++++
 fs/gfs2/file.c                     |  13 ++++
 fs/namei.c                         |   9 +++
 fs/notify/fanotify/fanotify.c      |  32 ++++++--
 fs/notify/fanotify/fanotify.h      |  20 +++++
 fs/notify/fanotify/fanotify_user.c | 116 +++++++++++++++++++++++------
 fs/notify/fsnotify.c               |  14 +++-
 fs/xfs/xfs_file.c                  |  20 ++++-
 include/linux/fanotify.h           |  20 +++--
 include/linux/fsnotify.h           |  54 ++++++++++++--
 include/linux/fsnotify_backend.h   |  59 ++++++++++++++-
 include/linux/mm.h                 |   2 +
 include/uapi/linux/fanotify.h      |  17 +++++
 mm/filemap.c                       | 109 +++++++++++++++++++++++++--
 mm/memory.c                        |  22 ++++++
 mm/readahead.c                     |  13 ++++
 security/selinux/hooks.c           |   3 +-
 17 files changed, 482 insertions(+), 54 deletions(-)

-- 
2.43.0

