Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78431799F
	for <gfs2@lists.linux.dev>; Tue,  8 Jul 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752010265; cv=none; b=aGyRtOFsSpFQmBtfHDe305lpfChgnJjwTXY0FxTGs4OjIhCFvCqJLlxp0s0GQk8yvYjJ6Wme8NXdWmP/ZVXDDCdHtLOgTNCP6rNiaAUsWWRuh1VQd5AkOVC19hjWnfh2S9OoObFjSTlxshJfJjUbri2AAtQ8YjjNcTQ/AGXYtvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752010265; c=relaxed/simple;
	bh=pHbIZYR/cPjhqgkSQJwswTCukX1J3YAVEComlN6LLFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=as0JiPskw7RXb+Vqy/L0KhPCFIjmTesDWwp6D3IRMtSwEbnNV86UmBi2X2sPRb0+W9cm6dku/fa9NWAnLO8gYtp4Q4TroTOkdudB8HUBbfro77JmG5rgyO3f6o2goJQ5EoLPaQ5cpf1UgTpknCoTQSMmsVCRB8IBLadO5+IHP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyUYWP0L; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyUYWP0L"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d7cf6efc2fso288371085a.3
        for <gfs2@lists.linux.dev>; Tue, 08 Jul 2025 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752010263; x=1752615063; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZUU5TRDaN6ALyyrygW/6RzwmiAYhH4pOYiMcpic0/PY=;
        b=GyUYWP0LOkEW6qlC7egqwgPXLj6Ps6TmEZH0ZfMenEnILBkQKBxn9NV43tqhX7JTQA
         TUiefivef/XB7cS74VBFDoNiTqh+ctdZoWXh+ZzcW8Yqrrdkg3DtrQEIqUS6J+tvSKHv
         wZqILIsNEdcDe9biWdC84V43ZqElWIhNRYxFTvMRRMc2GVOl7GiqFW+zUpVrcICz4D0Q
         4yfbVFUUT4RkfYjelL+sXBSpRxYCEvm750VOKNkLeGh+n77MyZXd+gL08ZyS8WVMcmvs
         bz4UDL+wwzsy5LfJW1+ctvVw4nPimL9uB04el0bisJZPcktAimiFAAiKtdW0NUXWmj+0
         FR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752010263; x=1752615063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUU5TRDaN6ALyyrygW/6RzwmiAYhH4pOYiMcpic0/PY=;
        b=P4fBt4qF/Y47qsKP51RiP5P2hHCnupusz0IYJNfrAAdAinCB6aCI7yy7OCOhfNP6me
         1Kuidm+Ya7fvxbvd+kBlEhCmGSOeHMbdB2uVexwGnYuE+/Zb0PJiXWrBXOWoV+p5wWtu
         OEMmxV2prpqeLamZ1jAfLzHrybxEDH4aM42gDi8w1JHto4dLP2XLRoZkuB902WpqkXk9
         XNdx3lrUEKGrJu2FVdFlYXC+Iif+2pxX0DtXXcHO9kPC+qH19Q+MvnUD5yGR2SUl5ux5
         n+0GYFJa9xDwZJ6GHRudngyl0fZ80X1bZX2lHjz4Qp7wgMPapIb5gNfot1qTC5/xNEtD
         +rHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcInp0E1WCLyMInwcgYt9xDpJupCfs6hnAAADn+ARgFvtRTbmu7Oe5A0cRjH+VbASbuX/r@lists.linux.dev
X-Gm-Message-State: AOJu0YzA8EB9bDKKsPm0ZCO6YRt2pjR+EcpY6HqiIBemo7SrR+aNs/xk
	/aTz9BKv7jYCvx/EnxICWpmKb+b3XO9i5UFfKsIxfwBgUKc+KeAaIH1TrNT9IHhMcpHWHLUAH+I
	W98jIhfmXlpCMpCa0RlouvXJ8s70xQm0=
X-Gm-Gg: ASbGncsKUoGAyev3DuC8xgQ3rMLlZfeBfUxzJam+3h+juldIEE5Eihzju003pUweZRX
	qSaga+tzdZIypSaxoctLuS8oHYo7H+uqsTl2CYXu99QiR5Dw2r9nJ8y9jfdd0gLNVMwtrt7kFvL
	0aT+FGDpYW34vdGkiWdwQYyG1jZgQ56XbaCdZc7OZpRmA=
X-Google-Smtp-Source: AGHT+IH0d/vk43vmyXPKIpP94pCK3w1qCzYdnwJNVDW8qW5d8MHocQso6Lt/gQSIfRkmy6R/U41ZJn66Xk4Bv0SJdK0=
X-Received: by 2002:a05:620a:2544:b0:7d5:d0a1:c907 with SMTP id
 af79cd13be357-7db7cfa32f5mr45846185a.30.1752010262414; Tue, 08 Jul 2025
 14:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de>
In-Reply-To: <20250708135132.3347932-1-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:30:51 -0700
X-Gm-Features: Ac12FXwa5YtLizBFDxdywhwayE5_QcC1_suEMiJs_748sHEtc47znVbUJrRxab8
Message-ID: <CAJnrk1byAutqR6A1fyqKHvoAisK=MfrfD1p778dPqZDBPsp+Wg@mail.gmail.com>
Subject: Re: refactor the iomap writeback code v4
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Hi all,
>
> this is an alternative approach to the writeback part of the
> "fuse: use iomap for buffered writes + writeback" series from Joanne.
> It doesn't try to make the code build without CONFIG_BLOCK yet.
>
> The big difference compared to Joanne's version is that I hope the
> split between the generic and ioend/bio based writeback code is a bit
> cleaner here.  We have two methods that define the split between the
> generic writeback code, and the implemementation of it, and all knowledge
> of ioends and bios now sits below that layer.
>
> This version passes testing on xfs, and gets as far as mainline for
> gfs2 (crashes in generic/361).
>
> Changes since v3:
>  - add a patch to drop unused includes
>  - drop the iomap_writepage_ctx renaming - we should do this separately a=
nd
>    including the variable names if desired
>  - add a comment about special casing of holes in iomap_writeback_range
>  - split the cleanups to iomap_read_folio_sync into a separate prep patch
>  - explain the IOMAP_HOLE check in xfs_iomap_valid
>  - explain the iomap_writeback_folio later folio unlock vs dropbehind
>  - some cargo culting for the #$W# RST formatting
>  - "improve" the documentation coverage a bit
>
> Changes since v2:
>  - rename iomap_writepage_ctx to iomap_writeback_ctx
>  - keep local map_blocks helpers in XFS
>  - allow buildinging the writeback and write code for !CONFIG_BLOCK
>
> Changes since v1:
>  - fix iomap reuse in block/zonefs/gfs2
>  - catch too large return value from ->writeback_range
>  - mention the correct file name in a commit log
>  - add patches for folio laundering
>  - add patches for read/modify write in the generic write helpers
>
> Diffstat:
>  Documentation/filesystems/iomap/design.rst     |    3
>  Documentation/filesystems/iomap/operations.rst |   57 +-
>  block/fops.c                                   |   37 +
>  fs/gfs2/aops.c                                 |    8
>  fs/gfs2/bmap.c                                 |   48 +-
>  fs/gfs2/bmap.h                                 |    1
>  fs/gfs2/file.c                                 |    3
>  fs/iomap/Makefile                              |    6
>  fs/iomap/buffered-io.c                         |  554 +++++++-----------=
-------
>  fs/iomap/direct-io.c                           |    5
>  fs/iomap/fiemap.c                              |    3
>  fs/iomap/internal.h                            |    1
>  fs/iomap/ioend.c                               |  220 +++++++++
>  fs/iomap/iter.c                                |    1
>  fs/iomap/seek.c                                |    4
>  fs/iomap/swapfile.c                            |    3
>  fs/iomap/trace.c                               |    1
>  fs/iomap/trace.h                               |    4
>  fs/xfs/xfs_aops.c                              |  212 +++++----
>  fs/xfs/xfs_file.c                              |    6
>  fs/xfs/xfs_iomap.c                             |   12
>  fs/xfs/xfs_iomap.h                             |    1
>  fs/xfs/xfs_reflink.c                           |    3
>  fs/zonefs/file.c                               |   40 +
>  include/linux/iomap.h                          |   82 ++-
>  25 files changed, 705 insertions(+), 610 deletions(-)

Thanks Christoph for all your work on this. I'll pull this and put v4
of the fuse iomap changes on top of this. I'll send that out this
week.
