Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93D21D59E
	for <gfs2@lists.linux.dev>; Wed, 26 Feb 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590871; cv=none; b=GAPl8tEUwIIX9rscmzdid63cQeOT8wagH/21KFoIP+NC8d9IHLjyHLO3a4vRJ9Hp19ECgrcvDlp0VUCMfgYwrhqFlUdlb7lcp3y3xOyCq9mrcoyQR9gV6nn8VlF9f1dRdiU+jij+vPaJkjOwc3tqaP2DDaNZc2k9pnA6sxjhG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590871; c=relaxed/simple;
	bh=f+6HBFqNbWMaeBgbA4hIOGBPqotBBNFFcmHh2kWxMAI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=OAC+SeF08Ss+WheTHLMlmOSINu8Dbd+dElTLx16Y7Ar+zW+/oyXZWl20KMu899xEKumX8wZgidJeyRQ0PCaGd7X79xiWCjnXCRG/OxSELFxIkSljKMx1SoaXYKCnJcrfwl6NyG3wdSVOJa3nMXx75NPwAaG7VZ4CVQTSC/2LrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa9u4MwY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa9u4MwY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740590868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HSaa3Q5nHNuq4+yTtOQ3pBDG3CVLETKbFLQeOv7Dq5I=;
	b=fa9u4MwYilBaoUrvcYNcUAFGiUlrkKdl8Qdl7VO53e7dm4NrRhG8NFzx0dEzUz2aB+acNY
	vhUkKNS/4eriiJtUWr18d7ULhbCp72WbUaaPBcwZ8n0Lkh2aGJNwEoJKlLSc/JylS7dRVB
	lER+niS+s3ZEPkG/0XOXNtoRQ7uWJ7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-3tq-Q4XfPKec11aDiRZxyQ-1; Wed, 26 Feb 2025 12:27:46 -0500
X-MC-Unique: 3tq-Q4XfPKec11aDiRZxyQ-1
X-Mimecast-MFC-AGG-ID: 3tq-Q4XfPKec11aDiRZxyQ_1740590865
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-439a5c4dfb2so370445e9.1
        for <gfs2@lists.linux.dev>; Wed, 26 Feb 2025 09:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740590865; x=1741195665;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HSaa3Q5nHNuq4+yTtOQ3pBDG3CVLETKbFLQeOv7Dq5I=;
        b=Rq5YvyBr1btlUqsAnHP/rVGvC894UI/x1ghDg/nweu1frllY3VXrB5aTOtK0dGtrek
         YlbRs1K4OqqgPoKPPqeK0bna5Gk6UUtzArGv0AsYCdwvGSxnRUpipNFMSmsNHiAzc2l0
         g4t5NZbGckrmfljG4QGYktrNhQBhIDSBdMbiYE1webX9K633F6e6S9BOe65C5jnPCiK7
         XGV952lBN+n/tVxvRNIpJcT0v1PqtSKF+f8DV/WNJGy0Xr456xyP2bvDzb2DLrlrhK/a
         UJ3nTXt5pNxHkms2wAje88gyL/IcaVyEWrEYql8wKoSQM6+GTfpgqtc24xLMhC+8jM+7
         XJXg==
X-Gm-Message-State: AOJu0YzNDFQLK6On1qWID82FBY15BM2yRndGHebGetkKjaZawPMvp2DW
	XMN2iP77dpuDOEsuPiR9XaE3TpC+Z6LiuqD6EATFpK8VtlR1u5ACRM00sCKrfH7DDoDCfS+HulZ
	5YHmDWG8OcE+3y5QrwDG0+kLc0CqTLZVghKbo1lEYcLXbbobJmeMF/lQkquHye/lv2PqyzMB4Mr
	w9SipFPTgUhDAqXCUn36y/YB8hxNVx48aSDw==
X-Gm-Gg: ASbGnctgea0U9RqT3I38cgZZFIywV6MjZudaQBJZZif2hQhB5cTM16mvMk66+pTeuBr
	Gvs6wN667SiXGXBZdIzKX/E5el7OlHicD0tAP1fmH4qBwpcFmCCnHzxNfuquQPa3da3vWj0wp1X
	ZwZtIHWjCwk3fkiMSmzahtnsdo9b4YIjyg6bRA+kaiVjFEcinizIKtof3oJB2tgf5L0Z13lXfk9
	zQUhbNkxr5l+FZhVmNHhUSHkVIPz5zhZA5TN2xsWAJRaZMtEWpXPgUQA0aiynDclaHNtM/z6Hso
	1d3zpjVIlbLZy06mtmucZeTDJVZ5p3qH3zD4bsA4RliBBAW0iS62SQxSKIuIHwXRolzEss12eMQ
	=
X-Received: by 2002:a05:600c:4f0d:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43ab90169d5mr35910715e9.19.1740590865019;
        Wed, 26 Feb 2025 09:27:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfHhz0d8M1WiYW9zaulTMKvXagL5pz4Q380xl25uP7RRCpz3iSYXFfWScQNyY4S4K64+TUZg==
X-Received: by 2002:a05:600c:4f0d:b0:439:98ca:e3a4 with SMTP id 5b1f17b1804b1-43ab90169d5mr35910535e9.19.1740590864588;
        Wed, 26 Feb 2025 09:27:44 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba532b2fsm28623975e9.10.2025.02.26.09.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 09:27:44 -0800 (PST)
Message-ID: <8f91c89d-609c-4398-b03d-49d3ff975f73@redhat.com>
Date: Wed, 26 Feb 2025 17:27:43 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gfs2@lists.linux.dev, users@clusterlabs.org, developers@clusterlabs.org
From: Andrew Price <anprice@redhat.com>
Subject: gfs2-utils 3.6.0 released
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Inr67DEhBOwNw7vf4eVDkpfCzu_TGP-ugmOvyAq-ZnQ_1740590865
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

gfs2-utils contains the tools needed to create, check, modify and 
inspect gfs2 filesystems along with support scripts needed on every gfs2 
cluster node.

The version has been bumped to 3.6.0 due to the removal of the last 
remnants of support for converting and checking gfs (aka gfs1) 
filesystems. We expect nobody to be impacted by this as the out-of-tree 
gfs kernel module was last supported in the RHEL 5 era.

Beside the usual scattering of minor fixes, cleanups and docs tweaks, 
gfs2-utils 3.6.0 includes:

  - A new `gfs2_grow -K` option to disable issuing discard to the block 
device.

  - A new `make rpm` build target (intended only to support CI testing).

  - `gfs2_convert` has been removed and gfs1 checking has been removed 
from `fsck.gfs2`.

  - `gfs2_edit restoremeta` to a regular file now truncates the size of 
the file to fit the filesystem.

  - Reproducible builds changes from the Debian package were merged.

  - `make CFLAGS="flags..."` now augments the used compiler flags 
instead of overriding them, simplifying the addition of options like 
`-fsanitize=address`.

The full git shortlog is below.

The release tarballs and signed checksums can be found here:

https://releases.pagure.org/gfs2-utils/

A direct link for this release:

https://releases.pagure.org/gfs2-utils/gfs2-utils-3.6.0.tar.gz

Please report bugs to the gfs2@lists.linux.dev mailing list or at:

https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2

Patches or pull requests can be sent to the same list or submitted on 
Pagure:

https://pagure.io/gfs2-utils

Thanks,
Andy

gfs2-utils changes since 3.5.1:

Andreas Gruenbacher (4):
       gfs2(5): Document quota=quiet option
       fsck.gfs2: Get rid of an unnecessary message buffer
       fsck.gfs2: Fix misleading comment
       gfs2_edit: Change savemeta to also dump unlinked inodes

Andrew Price (40):
       Update version for development
       Add rpm make rule for testing
       fsck.gfs2: Tighten offset check in check_eattr_entries()
       fsck.gfs2: Fix max xattr record length check
       fsck.gfs2: Fix xattr offset checks in p1_check_eattr_entries
       fsck.gfs2: Rename p1_check_eattr_entries to p1_check_eattr_entry
       Improve compiler flag handling
       Remove some CPPFLAGS duplication
       Misc. cleanups
       fsck.gfs2-tester: Improve restoremeta error handling
       Remove gfs (gfs1) support
       gfs2_edit: Add statfs fields to log header descriptions
       fsck.gfs2: Pass fsck_cx to builder functions
       libgfs2: Move jsize out of struct lgfs2_sbd
       libgfs2: Move qcsize out of struct lgfs2_sbd
       libgfs2: Move qcsize out of struct lgfs2_sbd
       libgfs2: Move uses of sd_time into libgfs2
       libgfs2: Remove lgfs2_freedi()
       libgfs2: Remove iov from struct lgfs2_buffer_head
       fsck.gfs2: Fix "check after deref" warning
       mkfs.gfs2: Don't refer to the target as 'it'
       Add doc/DeveloperIntro.md
       Update mailing list address
       Mention pull requests in README.contributing
       Update year in copyright notices
       Update translation template
       gfs2_edit: Fix up do_eattr_extended
       gfs2_edit: Check ea_name_len in ea_header_print()
       mkfs.gfs2: Remove unused copy of ea_header_print()
       mkfs.gfs2: Add a helper for debug-printing inodes
       mkfs.gfs2: Remove unused print_it() parameter
       Don't use the build date and time in version information
       libgfs2: Enable use in C++ code
       make rpm: Don't use rpmbuild --buildroot
       libgfs2: Add function to map block states to names
       gfs2_edit: Add timestamps to journal listings
       make rpm: Don't install to /usr/sbin unconditionally
       Update copyright notices
       Update translation template
       Prepare for version 3.6.0

Mark Syms (1):
       gfs2_grow: Optionally allow not issuing discard requests

Paul Evans (1):
       gfs2_edit: truncate to filesystem size at end of restoremeta()


