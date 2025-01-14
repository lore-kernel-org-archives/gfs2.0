Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2464D227B9D
	for <gfs2@lists.linux.dev>; Tue, 14 Jan 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736877929; cv=none; b=AC6oaSKCfRIBY/Mg0IAVNOXIBAg1DQv9beZf/rrpm67UYpwbMbPQa0BPMlOXwXSHzaV2ZrQ94Qu5FLb4i6V82L8s0CtZPCGSHoQQofbgNe8f/LnniAg6afjciaCwefa/pQ0v9mEJ64cHS8EZzSrtCL4sk6Khg5bvpK7sQVB1b1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736877929; c=relaxed/simple;
	bh=rHrFbFSr8oA7PcxBrUzaNoR6emoPlWh0nilg7s8rDqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdQ9nkINCIjthnLKkmIYzR+Qy5o+yTMwGFFAexYRVGF8/32VVfZVnO4hKUIGxSilxFG0+GBGy/TXfcBKItHYWtNomsHexEW09wVNZX6sUogz3v/P7cswG0ROQrKQVFNRBS7Vt6/xBzf/ZOx8sYtlbLaSlaXHPhlJYcgLwzCaqE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RMSTvFWG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RMSTvFWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736877927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fR4FfFrKBIXfr5VMpSBwOitDkgT1fPynPrECh+Fo1Io=;
	b=RMSTvFWGSLqUz8nIyaU0XB3FAbeNM+ZdsiiyuS9/hqZh5NdrKdJhw1hDX7qG7S2EMRJQ73
	vWOvajZOtERBMxZIe7xYdmTmtWPK4JjAgQtLyuzqz8ELsy7Qk4/22cO4dllgnV4kr4CGsZ
	Lnhj7s6F1683VZrjmF+DofaSJQF51Rk=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-8QydlNNXMHyTi5qxDwHJvA-1; Tue, 14 Jan 2025 13:05:26 -0500
X-MC-Unique: 8QydlNNXMHyTi5qxDwHJvA-1
X-Mimecast-MFC-AGG-ID: 8QydlNNXMHyTi5qxDwHJvA
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-216750b679eso73360625ad.1
        for <gfs2@lists.linux.dev>; Tue, 14 Jan 2025 10:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736877924; x=1737482724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR4FfFrKBIXfr5VMpSBwOitDkgT1fPynPrECh+Fo1Io=;
        b=YRKjbQAiYdXLXFINsXcxflXEDm7+IF8RysGqAFlsxb9ethfId1jPU5FQztTaC5FYD2
         l4d0hm7xvjmsdk4qnkYNDDrOko3xCNm7cvUdaWYZwy9pkKt2tz6KYAPdFZo/zx3YpON3
         1tnVeRTOErgHdWfAGVp+g5l2vLS4j8c5z+0BISIjKcXtN6qhmEbOOL4Lbck1KFORgS5X
         0PBjPxsx2EaSO9+3/AH8fxBr64ABIY6GXHkhR4+EHquz97kcp3mulAaop6mCZxn49VTO
         BLK1w82Q9vAF7FUeunWA9Mk9gAivSA3OPr7XcC4j4mk8xuqhnptxdcZYeFgCdeSuCFIK
         rxQw==
X-Forwarded-Encrypted: i=1; AJvYcCVVY/hJTDdh5JaEvi9yzK0+iOSgttWHBL1iWsLBG5BoPyoR84mujZ2iQfk+zrhP6mwPf8Fa@lists.linux.dev
X-Gm-Message-State: AOJu0YyZXYhaw8BTahnc7GCYIoi2P6orLER/PKdkxe1vi8kymRpdRJXU
	1KM28tIlA2AUwsOZTyw+sXVh0WqGwvDTyH/mKGXwDRAJFMQKOnYJ2bt49ueqzw4ApQ4hLBindmT
	nAUfhybP7bNGjbrXEnVHWkS/JZXGKTWrTAnk8Wg4SOQvnNyB9C0Se0MeonBRW7tIYwPftG9mKom
	a0H8PfCqeAPogWja0KPjlnSXu42Q==
X-Gm-Gg: ASbGncvC23UZmQoq0PtQ9MHN9fJnn/rFKAhPju+kQFBN24CtAExZHrXB9/7IcAkhY3y
	h9kdpfRTibiua+GQVtGkht7IOBEKBs+ejfswS
X-Received: by 2002:a17:902:cec5:b0:215:8270:77e2 with SMTP id d9443c01a7336-21a83da4965mr382893735ad.0.1736877923821;
        Tue, 14 Jan 2025 10:05:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnIQ1bKYTCUptyjp6rfk1VkZqvxCakq7XwdWGZJhxuBFtjALI06UNLskeRl7HzlwtfNoUiWsJxBTuh+Y4Runk=
X-Received: by 2002:a17:902:cec5:b0:215:8270:77e2 with SMTP id
 d9443c01a7336-21a83da4965mr382893325ad.0.1736877923226; Tue, 14 Jan 2025
 10:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <F0E0E5DD-572E-4F05-8016-46D36682C8BB@m.fudan.edu.cn>
 <brheoinx2gsmonf6uxobqicuxnqpxnsum26c3hcuroztmccl3m@lnmielvfe4v7>
 <5757218E-52F8-49C7-95F1-9051EB51A2F3@m.fudan.edu.cn> <6yd5s7fxnr7wtmluqa667lok54sphgtg4eppubntulelwidvca@ffyohkeovnyn>
 <31A10938-C36E-40A2-8A1D-180BD95528DD@m.fudan.edu.cn> <xqx6qkwti3ouotgkq5teay3adsja37ypjinrhur4m3wzagf5ia@ippcgcsvem5b>
 <86F5589E-BC3A-49E5-824F-0E840F75F46D@m.fudan.edu.cn> <CAHc6FU5YgChLiiUtEmS8pJGHUUhHAK3eYrrGd+FaNMDLti786g@mail.gmail.com>
 <27DB604A-8C3B-4703-BB8A-CBC16B9C4969@m.fudan.edu.cn> <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
In-Reply-To: <31f0da2e-4dd7-44eb-95ee-6d22d310a2d6@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 14 Jan 2025 19:05:11 +0100
X-Gm-Features: AbW1kvbDqb8iDbmgnGEQii-qVDbHB4He0h9IW_KUx9qA6904iyX1LDYVkpXjVAc
Message-ID: <CAHc6FU63eqRqUnrPz0JHJdenfsCTWLgagX+2zywHNTcFoZA8XQ@mail.gmail.com>
Subject: Re: Bug: slab-out-of-bounds Write in __bh_read
To: Kun Hu <huk23@m.fudan.edu.cn>, "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Cc: Andrew Price <anprice@redhat.com>, Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4MzZuu4Zf34DT9dJOzhWudwjLbFaEE-y2C-PAmK_gOQ_1736877925
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 5:12=E2=80=AFPM Andrew Price <anprice@redhat.com> w=
rote:
> On 13/01/2025 15:54, Kun Hu wrote:
> >
> >>
> >> 32generated_program.c memory maps the filesystem image, mounts it, and
> >> then modifies it through the memory map. It's those modifications that
> >> cause gfs2 to crash, so the test case is invalid.
> >>
> >> Is disabling CONFIG_BLK_DEV_WRITE_MOUNTED supposed to prevent that? If
> >> so, then it doesn't seem to be working.
> >>
> >> Thanks,
> >> Andreas
> >
> >
> >>   We have reproduced the crash with CONFIG_BLK_DEV_WRITE_MOUNTED disab=
led to obtain the same crash log. The new crash log, along with C and Syzla=
ng reproducers are provided below:
> >
> >> Crash log: https://drive.google.com/file/d/1FiCgo05oPheAt4sDQzRYTQwl0-=
CY6rvi/view?usp=3Dsharing
> >> C reproducer: https://drive.google.com/file/d/1TTR9cquaJcMYER6vtYUGh3g=
On_mROME4/view?usp=3Dsharing
> >> Syzlang reproducer: https://drive.google.com/file/d/1R9QDUP2r7MI4kYMiT=
_yn-tzm6NqmcEW-/view?usp=3Dsharing
> >
> > Hi Andreas,
> >
> > As per Jan's suggestion, we=E2=80=99ve successfully reproduced the cras=
h with CONFIG_BLK_DEV_WRITE_MOUNTED disabled. Should you require us to test=
 this issue again, we are happy to do so.
> >
> FWIW the reproducer boils down to
>
>    #include <fcntl.h>
>    #include <unistd.h>
>    #include <sys/ioctl.h>
>    #include <linux/fs.h>
>
>    /*
>       mkfs.gfs2 -b 2048 -p lock_nolock $DEV
>       mount $DEV $MNT
>       cd $MNT
>       /path/to/this_test
>     */
>    int main(void)
>    {
>            unsigned flag =3D FS_JOURNAL_DATA_FL;
>            char buf[4102] =3D {0};
>            int fd;
>
>            /* Error checking omitted for clarity */
>            fd =3D open("f", O_CREAT|O_RDWR);
>            write(fd, buf, sizeof(buf));
>            ioctl(fd, FS_IOC_SETFLAGS, &flag);
>            write(fd, buf, sizeof(buf)); /* boom */
>            close(fd);
>            return 0;
>    }
>
> So it's switching the file to journaled data mode between two writes.
>
> The size of the writes seems to be relevant and the fs needs to be
> created with a 2K block size (I'm guessing it could reproduce with other
> combinations).

I've posted a fix and pushed it to for-next:

https://lore.kernel.org/gfs2/20250114175949.1196275-1-agruenba@redhat.com/

Thanks for reporting!

Andreas

