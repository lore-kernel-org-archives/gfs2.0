Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBB198A3F
	for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935571; cv=none; b=pQmyXFEt6VjgYEKu5/n9WINaWoe3l6s0XjWf9IzrQbn2dBOMb4DrHJl1XLtCu+Eofae7M/0TZHshe+lZ4zNUt8TWKkEjj7nINtaB7ZpfrLaMBr0dKmEm15TYGBtAuyY5z6Ohv2lSR4E6iR+wPFcHNF34++WxXsn+JxwUvHw/0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935571; c=relaxed/simple;
	bh=AgFY0CuJppxazQdPyDFglzw3FHBPTJ3pB1JFaFZV/QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1HtIJLnng7m1quLqiROM4D38MAsV85D/+KX4taTy3SdQP14Bi/XaWw/VryGB2IXgXCXdx9VuoJr1BwjVXLNeXj5LSDtYCCmTSRbtmO9AZeagSk4gT89CeV90ArUfHE2Fm3DcL1u0B2Kq2U+PzABfT6Kge7ypUUa3v1Zo0xweYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=Lk1U34zX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="Lk1U34zX"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-456855afe0fso1744341cf.3
        for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724935569; x=1725540369; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r7JkW1kGW/foMeqY4idmoG+qoBfKoOOnmzhQ4sgndEI=;
        b=Lk1U34zX3akgBAvOU1vRZ7nNUWozW/cFpJtFfkVNt4WkRHWCxG2lTBWFok9kfbuH5y
         ypVd4hFnn9kKK0LrXex0FDLjtLFh93ZD1tbwisr4a7WERGmV9RrPbP3V3QkYVA1iCTjz
         V9E63iGqrdrLGv+I8lOBfY21Y9vpo5D1MaR35wm7YmvWFSq/MwAWMpECUkB8S+wUFqty
         nu5aTdtDdImswfAEtrtk761bWr9FTt8wkmCV3TcyTbKbgE7/ogTfpMvWaF4izDxnrshH
         r4jXYA2Ckpzf8aitbyfh+wZjzO1CIFLi5mfkrBB8KnXpLBcVBTT5VOcr+lbHWrA60byZ
         KdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935569; x=1725540369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7JkW1kGW/foMeqY4idmoG+qoBfKoOOnmzhQ4sgndEI=;
        b=SeebR8ynKqNOl6ogeJLtp4RBlg52BwWbNFaMi/8QEoHZ0AhMAZtTEN9hbaNC1siE3H
         jyidApa/UIIB0CW9r5qpNy7VjKGWYQW4ajWObbNLGRvUJRQ4qFo3hIqJHDZnDnBCn+nd
         5frvLDQylEyBqiOssn2S7H8z04tSloZOF6wrUVPuBIEb93wVyVZ/WCFY1rcoltsYkPCB
         YI3ZFLhlSkORl19Iak+xiGvlkQazOHPWJzUmhBF2MhlPi8sEc+AhabC4cJVHR+K0sCcJ
         xQSxj0fS+YXi6FbAqfdBA2mqX0Pm7kR6jWImddiFsOoWLy1v6Q2J8nsSvsDrsf/xpXUT
         KNkA==
X-Forwarded-Encrypted: i=1; AJvYcCUudIwKFASxSJWdiCVKAIdnyNKVestVeb4AraMUlyOnej9zdrMRnCZAQpluIGV5PZMYYSHr@lists.linux.dev
X-Gm-Message-State: AOJu0YwsrHdTCyFjQuajceYTQqYHPJLx/D6BlSROToCf+qmIFW+5v7Bf
	klt/SUPhwyGCUiVIzDkvaYnR9qjtPmfQA6mmsjn+JABSGsYxz4RgUcO1ASWuEBo=
X-Google-Smtp-Source: AGHT+IEjg71/rsVeutV6nh+K7FzjMZMNrg7qdXnGqs9sjXtDgQQ0paOoCdMyiPmGsrXRfVqUngI+Xw==
X-Received: by 2002:a05:622a:5585:b0:44f:fef0:70c7 with SMTP id d75a77b69052e-4567f710518mr29246131cf.44.1724935568801;
        Thu, 29 Aug 2024 05:46:08 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45682c98196sm4526271cf.31.2024.08.29.05.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:46:08 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:46:07 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Jan Kara <jack@suse.cz>, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v4 14/16] bcachefs: add pre-content fsnotify hook to fault
Message-ID: <20240829124607.GC2995802@perftesting>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <9627e80117638745c2f4341eb8ac94f63ea9acee.1723670362.git.josef@toxicpanda.com>
 <20240829111055.hyc4eke7a5e26z7r@quack3>
 <zzlv7xb76hkojmilxsvrsrhsh7yzglvrwofxcavjo4nluhjbdu@cl2c4iscmfg2>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zzlv7xb76hkojmilxsvrsrhsh7yzglvrwofxcavjo4nluhjbdu@cl2c4iscmfg2>

On Thu, Aug 29, 2024 at 07:26:42AM -0400, Kent Overstreet wrote:
> On Thu, Aug 29, 2024 at 01:10:55PM GMT, Jan Kara wrote:
> > On Wed 14-08-24 17:25:32, Josef Bacik wrote:
> > > bcachefs has its own locking around filemap_fault, so we have to make
> > > sure we do the fsnotify hook before the locking.  Add the check to emit
> > > the event before the locking and return VM_FAULT_RETRY to retrigger the
> > > fault once the event has been emitted.
> > > 
> > > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > 
> > Looks good to me. Would be nice to get ack from bcachefs guys. Kent?
> 
> I said I wanted the bcachefs side tested, and offered Josef CI access
> for that - still waiting to hear from him.

My bad I thought I had responded.  I tested bcachefs, xfs, ext4, and btrfs with
my tests.  I'll get those turned into fstests today/tomorrow.  Thanks,

Josef
