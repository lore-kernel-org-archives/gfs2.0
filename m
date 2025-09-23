Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB564275AED
	for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758627875; cv=none; b=a1Zk6FUlpgi2Xcp1YK6hP4DZABqJlYRhkZOwsrBd3GFp1J5ydyVxemCQjXE9c7p/tvQHccKYyHYHlyKgREB85fmAZyFdycH88C/sG3a1SRgAHL9dAs74fnTp3o3y0PhS5RSzn2t1gNrDbYfRRS6PxXnIu+Ph+qj9uG3Oy6A7QF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758627875; c=relaxed/simple;
	bh=IrwBtr41Ejbc9u6SFXsWNUvjyVGHc3eeq1h2neY22mQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akhoPs2CLy9t7gWikrttdivGjj3AoAMpvR65J30PPofDM35jFreMvUcEmnkk+x+HUKr2cd0hJH9bn2ClFhKFgDz5ihwspvL48BlK2DOgtu0L9NFI0SuRCD3JpTIOZS0kRH/mFDZ+WVrYaCoykqxTM5byPgR8u825sL4PTnxWdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+ZVJ6EZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+ZVJ6EZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758627872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IrwBtr41Ejbc9u6SFXsWNUvjyVGHc3eeq1h2neY22mQ=;
	b=J+ZVJ6EZk1KU1FPzRJDxh41L5HoprE7Yob0Cc40Ss3rdV54UvxwXyY7+QPE0jP1QBRBJ0y
	cmPG2v+wy37ubWAdTSahePq7YdlynSem2lbYa1oux4qD62agSO3Okn7VA5RVJpn2gMJjoX
	/QGY9QcvLGbz/yAy2qGFBejOJSxiYII=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ixE3bq22PluLHFlBGmLTOg-1; Tue, 23 Sep 2025 07:44:31 -0400
X-MC-Unique: ixE3bq22PluLHFlBGmLTOg-1
X-Mimecast-MFC-AGG-ID: ixE3bq22PluLHFlBGmLTOg_1758627870
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-244581ce13aso96427705ad.2
        for <gfs2@lists.linux.dev>; Tue, 23 Sep 2025 04:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758627870; x=1759232670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrwBtr41Ejbc9u6SFXsWNUvjyVGHc3eeq1h2neY22mQ=;
        b=qkh8nq4p7J/BIEgSwFFcWLE2EtfX4+e5PJn3PjWmPWZNY4noeWX5ErRhxt8jEjuoqu
         bOBZVwIOgMeI8eUhc5AT9V1oauzZyqG8nqOjHPlKs8VnzAO6J+PfLQVelEN3dc/pyU1J
         idzrvrADh1L41LVWOSg6rfG1r8RKufGvU/IzihIWQiFNCAn1pPNXOnvujA3dbn8IACI8
         TOLkiSCyriMJeLCyW8FCRqqE+na+y6RWE25YbcXoLg5jlPoMjg/whdL6LFYBQ/pgrwzw
         i8lGUMWiac0HjR9N0lZiOAIJgoYAUNJFKzdgQzgdyoMDHokBN6HeA5/1TYIn6A0Cd65h
         9lUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpBNrCJoL/8Sp/w9AfqnvB9tYK4vpHwZBmmAI+xLK0I2c9erTxVHZCPp7bUXjfyoJXFmae@lists.linux.dev
X-Gm-Message-State: AOJu0YzXvNmxFNG52ovX///Dxv0Og8ceykytNY49FBShhg6vHIBT92+I
	6zvKaSk7fr88iyIWFo1CkyyVpeXl0PzU6EurRogt+25nsjX3ZAssjkYXRYFRkCABwBX7TmqV0vi
	EIbKBOYqHkR5CZKVpsuKIMF6vfGFOGKpd9joUK/1EY9FgNRq56cWQzAmmQOrtuRRWuop3hIuqw2
	urERhzYxGWMAZZx7wCdetN+R90jqNk0Q==
X-Gm-Gg: ASbGncuF0W0sW8Ap+jtrVgkVPPanf+bJP5S0ZWg/uCWZXK+SNB69GraISTH9auYny8d
	9/8r8AVwD0Eko6dGBNqn6EuCXnxiBeN90CKQz+60Q7wj9R9Dsu6jEO6VvsBLBVPlU14sOTNlmaC
	4Nu2ixzd1jrHdxtfK1ExA=
X-Received: by 2002:a17:902:db12:b0:269:b2ff:5c0e with SMTP id d9443c01a7336-27cc836bddfmr30428285ad.46.1758627870529;
        Tue, 23 Sep 2025 04:44:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Cwvw/2PZwtxl8crg/RvgpXu5cRzWVpQOiAlxqRp7folePTOl9sm88fsN+QGl4BwCYWwIjf0V3FoMcSkSUdA=
X-Received: by 2002:a17:902:db12:b0:269:b2ff:5c0e with SMTP id
 d9443c01a7336-27cc836bddfmr30428055ad.46.1758627870158; Tue, 23 Sep 2025
 04:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250911004416.8663-2-bagasdotme@gmail.com> <aNJ9yJ7XT4Pnsl9E@archie.me>
In-Reply-To: <aNJ9yJ7XT4Pnsl9E@archie.me>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 23 Sep 2025 13:44:18 +0200
X-Gm-Features: AS18NWBFz-QDudfkmwzdBEDlcV6uLY5XJ2s6wSqGZELeCos4n-LXvCn8eGBJ-fE
Message-ID: <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux GFS2 <gfs2@lists.linux.dev>, 
	Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jan Kara <jack@suse.cz>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	James Morse <james.morse@arm.com>, Bernd Schubert <bschubert@ddn.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, Matthew Wilcox <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GRzNBKZpBPXLH-5TypMGta7_jShUOPpQwn64zPx_g1Q_1758627870
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2025 at 1:00=E2=80=AFPM Bagas Sanjaya <bagasdotme@gmail.com=
> wrote:
> On Thu, Sep 11, 2025 at 07:44:17AM +0700, Bagas Sanjaya wrote:
> > Documentation for GFS2 is scattered in three docs that are in
> > Documentation/filesystems/ directory. As these docs are standing out as
> > a group, move them into separate gfs2/ subdirectory.
>
> Hi Andreas,
>
> It looks like this patch isn't in 6.18 PR [1]. Should I resend it after
> merge window (and for 6.19 instead)?

Ah, I was already wondering what had happened to that patch.

Can we just put this into the next (6.20?) merge window?

Thanks,
Andreas

