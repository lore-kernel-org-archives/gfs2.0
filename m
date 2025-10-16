Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7531DF970
	for <gfs2@lists.linux.dev>; Thu, 16 Oct 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633001; cv=none; b=PgDOb59Hx4pDD1TOFE42iCj6HY3lpsYSnniiR6ekoeI7VLz4kAIl4LI7eFZ6qonOfk+ARTmyA2FIurptjhxGtzwfU10Kk5YrcvqsaeEl6C9xzDu6rDsEgiUXVvGDtPAYwMc/8fuAQG5Th/p2NOQbccx/xCxMhB44Q+ER5O3qQdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633001; c=relaxed/simple;
	bh=hVQWi346CfFIRj57TmG7mDIKbGtDYBTuiV7lKs1NxxE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kz3NhLH7dOEVdyjOiKdcqBiPDXfBEGEFQ4lBUqVHSP9DqjRwQog2AsZWo8pVGnHWFR6uF6DaQaDdP4mhEPgtwvRIz9ZnNRaF+tKa6a1unF7D5yq+XsHf2C7h66EojfClunKt32rFFZZ4pXhDJydWg7eIat3hI1eCDqdeOruQ0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gYlY+t/e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYlY+t/e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760632998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hVQWi346CfFIRj57TmG7mDIKbGtDYBTuiV7lKs1NxxE=;
	b=gYlY+t/emEI6F5ODilabdWAsgO1P8UPlMwuz+kq381gFCMDRzvF9OZ4k8RjlEUhF1CZvXj
	vXkChRKyFpO95LoOJg4tJ3tIK8JoCXSOOrMzuLuHfiQWcT4Rs9MUou3WWC/BY2tm33GhDz
	yljiyimjVEYi2g+DF+zrY5jN5cRT7Ac=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-O1ZNDoOHN9CabRkp8OU8jg-1; Thu, 16 Oct 2025 12:43:17 -0400
X-MC-Unique: O1ZNDoOHN9CabRkp8OU8jg-1
X-Mimecast-MFC-AGG-ID: O1ZNDoOHN9CabRkp8OU8jg_1760632997
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7246755a21cso13053717b3.3
        for <gfs2@lists.linux.dev>; Thu, 16 Oct 2025 09:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760632997; x=1761237797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVQWi346CfFIRj57TmG7mDIKbGtDYBTuiV7lKs1NxxE=;
        b=SUPdOltcv0v4eEJYS7tBj/UGL3Ak1SgdiSLqijG95rKMoYlesxzpk65g8qKOrqhy2O
         g69SDvmStkJ5EEBaertNcAO0KlJnfQYV/sYQktgz943n6pMHLJ7/sPtQGVCjKdHmXlON
         O4E7iGdTAqxjCHWtZnBCNZGFpnsxhRaQvd+sddQbd2qhNHsqsJeOOULj9ptKRbg6PKlp
         CF8MVWtzndMwUFDZCHOwmb4FhEmKn7idZZlR+dSBbO/a8KbVbTshAJsnXA1KGY6X43u7
         uLzGLnE+WL+Z+OMjQ6vEvpe31afKvJxnTrItbZTzNLrRBtpuUWd/g/HqeU6NGVY/7IB+
         TRaA==
X-Forwarded-Encrypted: i=1; AJvYcCUW9FqICbLuuiFC9N5jg6QKkwecsI5gSa5NrHOLlfXJ8gql0/F6jKQMwmZm7XYXbVOgOkJU@lists.linux.dev
X-Gm-Message-State: AOJu0YzRoHi1F/eijEB0H59Oav8RJ7ZYzNyT+9TPVj4JiQVyATAdWLqV
	4g8P7IyhLva9t5JLd6FLiMNXuJBcuwDXzUdnmHp0EwY7OxuMoZa7cf81RPy5ynIFjEHO57tiZu4
	exMHA767aw+rU+homvBhNJ0iLJnOFo5Td6qmJjwmv7QUXHsIe7QeTSsd/tJLUHml78atmzVJDNo
	ZH6/foY5i+lG93WE6kE+mMzHM26Dx9vA==
X-Gm-Gg: ASbGncuk47HymNtsf2VdlnRTRXnzZ+mVXt+6lV44twsZSI836ZT13dL9O7FPoBsQ0zn
	r8i9XLjCQpYztB2+HtHmTOEPwxMZkilYOCZBMMos4X2N0PlZhEMjVRw4/M5S5wOF3uuTnLMXlpl
	NK+yOjw26LVaag8KeJBqK25/ZkYjwK5lcVtL4WQUBhxMi9HbMqFuGKcA==
X-Received: by 2002:a53:c057:0:20b0:628:fd1c:c3d0 with SMTP id 956f58d0204a3-63e161391abmr659544d50.27.1760632996779;
        Thu, 16 Oct 2025 09:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7mB3OeCFADl+jf2RSpEiGzKJOZy5msvHxNe0q5ZhXMEg1AZ+3Dae1uL8nRfkXcQoadqgSmyaXNBTPb9hTvMk=
X-Received: by 2002:a53:c057:0:20b0:628:fd1c:c3d0 with SMTP id
 956f58d0204a3-63e161391abmr659517d50.27.1760632996336; Thu, 16 Oct 2025
 09:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <68ef030a.050a0220.91a22.022a.GAE@google.com> <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
In-Reply-To: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 16 Oct 2025 18:43:05 +0200
X-Gm-Features: AS18NWAlVrld73zUQk8uQm4oUFpr0k3NrXS-m7lewNfHMU6fVdnI_G8q45y50Vw
Message-ID: <CAHc6FU5Ay5HostiVPxyE_DuE-djScdV32B3iDrzsnX6e7-UWgQ@mail.gmail.com>
Subject: Re: [PATCH next] gfs2: Add sanity check for sd_jdesc
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com, 
	gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kg3qVDGHi_6L3X7ntqXQ0zYMaLuVDw0FMeY6AOhO8SI_1760632997
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Oct 15, 2025 at 12:00=E2=80=AFPM Edward Adam Davis <eadavis@qq.com>=
 wrote:
> Asynchronous withdraw, when sd_withdraw_work is scheduled later than
> put_super, will set sd_jdesc to NULL when clearing all journal index
> information, triggering the syz report uaf.

that's not quite what's happening here; we are actually looking at a
failure in gfs2_fill_super() which calls init_inodes(UNDO) ->
init_journal(UNDO) -> gfs2_jindex_free() before flushing the
asynchronous withdraw work. A similar ordering issue exists in
gfs2_put_super() as well, though. I'll fix that in "gfs2: Asynchronous
withdraw" by moving the flush_work() calls into the proper place.

Thanks,
Andreas

