Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66EA27BF78
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918734; cv=none; b=Rwn/nklYQ2oy47hEsSe1mBpw13FTKWLtsNCDUnr/vvmMPfrYxtwwX6JuIvewKzlgUiKkRs6DSNgdS/3ag7RWLHRW5u3cuu2pDZiHbdZBpmO+QjbThovhYxS1rdVjK4WeHv3zYt9hRS64Mpmj1bJyqYoKDJ4xao6S5JB28rhC+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918734; c=relaxed/simple;
	bh=xERf7vHlFIL2VDrHQAot2BofgGPAsHr+KMDATnN/iow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jop0wm5VERdZWt4Jg/fu+ncFTf+1ggWeK/n9en4JUtKpc8ZVUIrImGqFDoeos03w8thozT2fMptsZg2nFHR9BpgY8eaZ32v56CGUVL7HtcwpdUXf6IONEFZVXIUCPvvETEaAuYX0tF9c0krQv1pjPn6kGc2EHNCD8iawzdFnZ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeZF8bQj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeZF8bQj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745918730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xERf7vHlFIL2VDrHQAot2BofgGPAsHr+KMDATnN/iow=;
	b=UeZF8bQjkKs/SRKvHRLU0ws589OH86rLvJTPxX1IMJ7Tulq6Uc9NQhY3JmxEiO58D+xM1g
	si5YnfIuKO26jYQYKniCv6FZR9DxEqdyzbNXV+gx6lvOC5OxGTmOJL4PTt/MQyv9nFi35s
	Ui1yb/RroVnuK0WoqUv9K+42e9FR+CY=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-Zvn4mCnINn2Qz2GUqD3YAw-1; Tue, 29 Apr 2025 05:25:29 -0400
X-MC-Unique: Zvn4mCnINn2Qz2GUqD3YAw-1
X-Mimecast-MFC-AGG-ID: Zvn4mCnINn2Qz2GUqD3YAw_1745918728
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-227ed471999so49743185ad.3
        for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 02:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918728; x=1746523528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xERf7vHlFIL2VDrHQAot2BofgGPAsHr+KMDATnN/iow=;
        b=ox4HfHDYp1pNGcLtU/5L1qbmpd0fUkyC5HCqS0Zk2MzidB4+UyE8xVjdsyvmKgSSJO
         tT/qLQfI2Y+yc+BWdutQaW7mV7qOBL6uBF3t6u+4q5ZqRV5/wpoiH2XW5agSPlJQxCeW
         9Fyt17HsbPVGk/ACuLiqkjMm2LRylLv12Jr9DB/3vj6QIyrH5LIMtgTA4w+z8l+iBYuz
         HSX+xSKQCTddp56j7nKQFRcBNyY1PTlONaB3hFdvPblAyMZsM2IpD2D2ZHcphh6Skfpj
         MU7gf8XyHFo66RqtYPcThZpcTnfHihw12NRKYl0ujJXYzW4fDr/pdtpIbOxgVBbfc1Rt
         tyYw==
X-Gm-Message-State: AOJu0YwKxKKJ/lRV8rshxiixo0oYkPILjwwekkJsFyZ+TExnD9l2aRM+
	1RSm49HI8wc61Mj1hA7EUMsT8nMp10d6Q3YAa7wLGxX8gC8bfyjoeaWXAQIVd8B6mThxBpZCIEN
	9Oe+zY2QpwRyN/jNneKolCclquu6VVPzZsPD65tmtbRoxyBnfsajswDNVAtFfcIMiQ/d5XRSfEt
	byCzsKhU7xxxEor52XhIQGHG+Vwd+vM+KcN3W7
X-Gm-Gg: ASbGnct95DKJ6oqBssWI+MTNsROSfat1PRebgW9oqwrtRA8VrhE5JM9vX+UhY8+bRwO
	6FTLvgAQhFwbpffj2rnKWpcVQMgXqAnuokI3Y9XkiL7RAK85HQaIEEMZjFIonjWMUGuA=
X-Received: by 2002:a17:903:1aa6:b0:224:2201:84da with SMTP id d9443c01a7336-22de6e9398fmr27498395ad.6.1745918727845;
        Tue, 29 Apr 2025 02:25:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVqkYKPDA3m8eZjQYkl9+oqiAw3JmlRKFlZJFTl3uMOmJOX0LPCdF+LXHVZBxZ09wACQxTwiZJFceKQ5kkHxk=
X-Received: by 2002:a17:903:1aa6:b0:224:2201:84da with SMTP id
 d9443c01a7336-22de6e9398fmr27498245ad.6.1745918727570; Tue, 29 Apr 2025
 02:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250429054916.2343-1-liubo03@inspur.com>
In-Reply-To: <20250429054916.2343-1-liubo03@inspur.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 29 Apr 2025 11:25:15 +0200
X-Gm-Features: ATxdqUFmtaHxt2eRXopHROg80aacxgsBoKLG4yU5neNp4VgR_wOY5W-IVEtIS08
Message-ID: <CAHc6FU4wHTMaJqe-kijPrNQ2j83xqp-JeO3UtLiN7fCm91mL3w@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Remove set but not used variable 'xattr_initialized'
To: Bo Liu <liubo03@inspur.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kpCbleizCyXbtoZ69o1YWmYQ0_lYP64_0Jt3PfT5U2A_1745918728
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 29, 2025 at 7:52=E2=80=AFAM Bo Liu <liubo03@inspur.com> wrote:
> The variable xattr_initialized is assigned and never used, so can be remo=
ved.

Thanks, but this patch is against a broken version of "gfs2:
deallocate inodes in gfs2_create_inode" that has since been fixed. As
a consequence, this patch is no longer applicable.

Andreas

