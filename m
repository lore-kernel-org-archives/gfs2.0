Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786861FDA82
	for <gfs2@lists.linux.dev>; Mon, 14 Apr 2025 23:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672966; cv=none; b=dQ6bSD2GcFbObd27rVhBxUllG8qHYWT4j8g2Kpl+En8lzUpg7ksnnNNBhRMLp9UfPqZQuZ/PwnexZ1ndPMIwp/cy8RbLZmQkUYa6RFQws9Arm22ZjcNwmi9vrbp3qgQGRK2TwKBnYTSgNnm0BvCLh9HCTFyehcM6VJkYOWrSE0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672966; c=relaxed/simple;
	bh=4DnMfpFmbLxGeVz6jjMyOFFoUcbKIrrGS/xuWDmkbAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQWwH75oSMvYnLmVRnKpuGy5cr0GDngg4tiZ20wNcXVUNEtJyRyCOGjR0tmWN2eAoLkcwFIqLzwt243BUYu0gWJlCROwOeyY5aUsWzqywQxHBpOUaMZpmP3ChxHAvwqKQg8X3z5eigeboxDVx3jte0UU9d42Ipj8xddsCaxojpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1G23YT8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1G23YT8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fTqOfhVMO3oX7s5hEfhf7N6UJGTux5HLcHvFLo78+oQ=;
	b=W1G23YT8eX4X/JKvyGKcvkVY0RacmhzpmTCF3zkQ4Hss3YlWCnvhysPHLyohgCWUSwscLq
	as7uKAfYslKfN+9Vh1UaWkn5Rcn1mALi3z+D54fGh357PfdpeERCoXxk8OCZS159PGn6Ke
	2RXd8KBaA2Y6pU/2CSiSu+TlamlwC/w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-PFBrYFxoOtarCF3spF4qmw-1; Mon, 14 Apr 2025 19:22:42 -0400
X-MC-Unique: PFBrYFxoOtarCF3spF4qmw-1
X-Mimecast-MFC-AGG-ID: PFBrYFxoOtarCF3spF4qmw_1744672961
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2241ae15dcbso55224335ad.0
        for <gfs2@lists.linux.dev>; Mon, 14 Apr 2025 16:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672961; x=1745277761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fTqOfhVMO3oX7s5hEfhf7N6UJGTux5HLcHvFLo78+oQ=;
        b=dFDc+VV+VECtOAOYAbXh79zHPhahHNlKns9KftyS+4NVcuLPHYACklnDk1/mI4KshL
         R6qsr/Nq+V8cBNni6Q5lkfbeT3M8H0OiZlZP6gKmRZk4li5JQtaA791XuuU5OHF7E4q/
         AQbj3xLm73IhUtj1hj/6eOy4kvhwF6mRBzVjGLEtoFrNKoW+kmYE12kXkvzBjllFSly3
         F7YzPOaZDB3y5/H+WKkykUeFwLuX7pp+/2i/fAVgKV0L+E8q18XgjNZ2jTrN+JT5VH/P
         DVv1NpPHz7Wci82tt5dB+CSvbTRCghKmjCBuSe+9xKnCWPt1XFn4sxJptc1c5M3kcTwd
         TSvA==
X-Forwarded-Encrypted: i=1; AJvYcCVe0/BkeptGiv39NatZOZSwRI3NYDkOUas8rVvJS/CpLFO038b8D2auIStmsmMVNN/b8683@lists.linux.dev
X-Gm-Message-State: AOJu0Yxo+qZ4Xa2WF0X6kvSvjv/dHJyjvomU0bwr7LCJmIKGLReF7Jd3
	a9UpIxCNDYxfnN+usJ16bqNnj7FI0TmD3jbeZSWdoepgqttyIUZHXGKNxlPIF/jzEIHw2mFEamN
	hueDEF9K0Sn9NthcQN32sa+07CWBeRF2WkTqT/AOzhqW+DWQi8vKy4FhrIR5hQtGCpnX2YKzo9P
	pJOLonY09FFyA07P+LUsY3QOK4GQ==
X-Gm-Gg: ASbGncv3vAgi2GH0eqiJgq7dItytN9LJIvUxA+f96osLDpRLif4HJl9i90alq1VAWux
	SOqEDcKBq5HUfS/wqupLnMPwZyZGABMCKXq6L89pHi6wVXUMiUWSFfLr92chaFGw3gBk=
X-Received: by 2002:a17:902:ea10:b0:21f:1202:f2f5 with SMTP id d9443c01a7336-22bea4a1e41mr165046235ad.8.1744672960905;
        Mon, 14 Apr 2025 16:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1AHsKSZHKc3ZG9l2EOP9IVYFBrGDAU7Mxy/wvMCYvA1yfGQ8huWiBkzCVojnxML9vlgqyT86Cp7v0R0BshkY=
X-Received: by 2002:a17:902:ea10:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22bea4a1e41mr165046005ad.8.1744672960646; Mon, 14 Apr 2025
 16:22:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250412163914.3773459-1-agruenba@redhat.com> <20250412163914.3773459-3-agruenba@redhat.com>
 <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
In-Reply-To: <20250414145120.6051e4f77024660b43b72c8a@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Apr 2025 01:22:29 +0200
X-Gm-Features: ATxdqUGev3hKkKP_xReo0nZ3C7cPj6MnUdmVFecbVAT6bl5u52ieWp2nkeKtLgg
Message-ID: <CAHc6FU4CAzrNO24izcwYXFt-K0WFUdM6y0bAzmW6nb1CS0sexg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2@lists.linux.dev, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bVe5fgPSMRgvSA8wF6HDstFNq-_7v40AotlVucSJKhI_1744672961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:51=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.c=
om> wrote:
>
> > inode_to_wb() is used also for filesystems that don't support cgroup
> > writeback. For these filesystems inode->i_wb is stable during the
> > lifetime of the inode (it points to bdi->wb) and there's no need to hol=
d
> > locks protecting the inode->i_wb dereference. Improve the warning in
> > inode_to_wb() to not trigger for these filesystems.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Yoo were on the patch delivery path so there should be a
> signed-off-by:Andreas somewhere.  I made that change to the mm.git copy
> of this patch.

I guess that's fine as long as Jan is credited as the author.

Thanks,
Andreas

